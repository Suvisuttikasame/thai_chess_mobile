import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thai_chess_mobile/models/piece.dart';
import 'package:thai_chess_mobile/models/room.dart';
import 'package:thai_chess_mobile/providers/game_provider.dart';
import 'package:thai_chess_mobile/providers/room_provider.dart';

class GameBoard extends ConsumerStatefulWidget {
  const GameBoard({required this.height, super.key});
  final double height;

  @override
  ConsumerState<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends ConsumerState<GameBoard> {
  @override
  Widget build(BuildContext context) {
    final roomState = ref.watch(roomProvider);
    final gameState = ref.watch(gameProvider);
    final Map<dynamic, dynamic> board = gameState['board'];
    final Map<dynamic, dynamic> footPrintMove = gameState['footPrintMove'];

    void tapHandler(int index) {
      //make move
      if (footPrintMove[index] != null && gameState['mode'] == 'readyToMove') {
        //check kill move
        //or normal move
        final Map<int, dynamic> newBoard = {...board}
          ..remove(gameState['movePiece']['position']);
        gameState['movePiece']['position'] = index;
        newBoard[index] = gameState['movePiece'];
        ref.read(gameProvider.notifier).move(newBoard);
        return;
      }
      //reset move
      if (footPrintMove[index] == null && gameState['mode'] == 'readyToMove') {
        ref.read(gameProvider.notifier).resetMove();
        return;
      }
      //is valid tap
      if ((gameState['board'][index] == null ||
              gameState['board'][index]['side'] != gameState['side']) &&
          gameState['mode'] == 'regular') {
        return;
      }

      //find footPrint
      final piece = board[index];
      final Map<int, dynamic> move = {};
      if (piece['pieceName'] == PieceName.pawn.name) {
        if (piece['side'] == Side.white.name) {
          if (index + 8 <= 63 && index % 8 == 0) {
            if (board[index + 8] == null) {
              move[index + 8] = Colors.greenAccent;
            }
            if (board[index + 9] != null &&
                board[index + 9]['side'] == Side.black.name) {
              move[index + 9] = Colors.redAccent;
            }
          } else if (index + 8 <= 63 && (index - 7) % 8 == 0) {
            if (board[index + 8] == null) {
              move[index + 8] = Colors.greenAccent;
            }
            if (board[index + 7] != null &&
                board[index + 7]['side'] == Side.black.name) {
              move[index + 7] = Colors.redAccent;
            }
          } else if (index + 8 <= 63) {
            if (board[index + 8] == null) {
              move[index + 8] = Colors.greenAccent;
            }
            if (board[index + 7] != null &&
                board[index + 7]['side'] == Side.black.name) {
              move[index + 7] = Colors.redAccent;
            }
            if (board[index + 9] != null &&
                board[index + 9]['side'] == Side.black.name) {
              move[index + 9] = Colors.redAccent;
            }
          }
        }
        if (piece['side'] == Side.black.name) {
          if (index - 8 <= 63 && index % 8 == 0) {
            if (board[index - 8] == null) {
              move[index - 8] = Colors.greenAccent;
            }
            if (board[index - 7] != null &&
                board[index - 7]['side'] == Side.white.name) {
              move[index - 7] = Colors.redAccent;
            }
          } else if (index - 8 <= 63 && (index - 7) % 8 == 0) {
            if (board[index - 8] == null) {
              move[index - 8] = Colors.greenAccent;
            }
            if (board[index - 9] != null &&
                board[index - 9]['side'] == Side.white.name) {
              move[index - 9] = Colors.redAccent;
            }
          } else if (index - 8 <= 63) {
            if (board[index - 8] == null) {
              move[index - 8] = Colors.greenAccent;
            }
            if (board[index - 7] != null &&
                board[index - 7]['side'] == Side.white.name) {
              move[index - 7] = Colors.redAccent;
            }
            if (board[index - 9] != null &&
                board[index - 9]['side'] == Side.white.name) {
              move[index - 9] = Colors.redAccent;
            }
          }
        }
      }

      ref.read(gameProvider.notifier).footPrintMove(move, piece);
    }

    return SizedBox(
      width: double.infinity,
      height: widget.height * 0.6,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
        ),
        itemCount: 64,
        itemBuilder: (BuildContext context, int index) {
          bool isWhite = (index + ((index / 8).floor())) % 2 == 0;
          return GestureDetector(
            onTap: () {
              tapHandler(index);
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: footPrintMove[index] ??
                        (isWhite ? Colors.white : Colors.grey.shade700),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.2),
                      width: 1,
                    ),
                    gradient: footPrintMove[index] == null
                        ? LinearGradient(
                            colors: [
                              isWhite ? Colors.white : Colors.grey.shade700,
                              isWhite
                                  ? Colors.white.withOpacity(0.7)
                                  : Colors.grey.shade600,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
                if (board[index] != null)
                  Piece.getWidget(
                    board[index]['pieceName'],
                    board[index]['side'],
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
