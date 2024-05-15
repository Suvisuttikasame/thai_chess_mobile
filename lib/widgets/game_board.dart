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
      var piece = board[index];
      Map<int, dynamic> move = {};
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

      if (piece['pieceName'] == PieceName.rook.name) {
        //col strike
        for (int i = index + 8; i <= 63; i += 8) {
          if (board[i] != null && board[i]['side'] == piece['side']) {
            break;
          } else if (board[i] != null && board[i]['side'] != piece['side']) {
            move[i] = Colors.redAccent;
            break;
          } else {
            move[i] = Colors.greenAccent;
          }
        }
        for (int i = index - 8; i >= 0; i -= 8) {
          if (board[i] != null && board[i]['side'] == piece['side']) {
            break;
          } else if (board[i] != null && board[i]['side'] != piece['side']) {
            move[i] = Colors.redAccent;
            break;
          } else {
            move[i] = Colors.greenAccent;
          }
        }
        //row strike
        for (int i = index - 1; (i + 1) % 8 != 0; i--) {
          if (board[i] != null && board[i]['side'] == piece['side']) {
            break;
          } else if (board[i] != null && board[i]['side'] != piece['side']) {
            move[i] = Colors.redAccent;
            break;
          } else {
            move[i] = Colors.greenAccent;
          }
        }
        for (int i = index + 1; (i) % 8 != 0; i++) {
          if (board[i] != null && board[i]['side'] == piece['side']) {
            break;
          } else if (board[i] != null && board[i]['side'] != piece['side']) {
            move[i] = Colors.redAccent;
            break;
          } else {
            move[i] = Colors.greenAccent;
          }
        }
      }

      if (piece['pieceName'] == PieceName.knight.name) {
        if (index + 16 <= 63) {
          if (index % 8 == 0) {
            if (board[index + 17] == null) {
              move[index + 17] = Colors.greenAccent;
            } else if (board[index + 17] != null &&
                piece['side'] != board[index + 17]['side']) {
              move[index + 17] = Colors.redAccent;
            }
          } else if ((index - 7) % 8 == 0) {
            if (board[index + 15] == null) {
              move[index + 15] = Colors.greenAccent;
            } else if (board[index + 15] != null &&
                piece['side'] != board[index + 15]['side']) {
              move[index + 15] = Colors.redAccent;
            }
          } else {
            if (board[index + 17] == null) {
              move[index + 17] = Colors.greenAccent;
            } else if (board[index + 17] != null &&
                piece['side'] != board[index + 17]['side']) {
              move[index + 17] = Colors.redAccent;
            }
            if (board[index + 15] == null) {
              move[index + 15] = Colors.greenAccent;
            } else if (board[index + 15] != null &&
                piece['side'] != board[index + 15]['side']) {
              move[index + 15] = Colors.redAccent;
            }
          }
        }
        if (index - 16 >= 0) {
          if (index % 8 == 0) {
            if (board[index - 15] == null) {
              move[index - 15] = Colors.greenAccent;
            } else if (board[index - 15] != null &&
                piece['side'] != board[index - 15]['side']) {
              move[index - 15] = Colors.redAccent;
            }
          } else if ((index - 7) % 8 == 0) {
            if (board[index - 17] == null) {
              move[index - 17] = Colors.greenAccent;
            } else if (board[index - 17] != null &&
                piece['side'] != board[index - 17]['side']) {
              move[index - 17] = Colors.redAccent;
            }
          } else {
            if (board[index - 15] == null) {
              move[index - 15] = Colors.greenAccent;
            } else if (board[index - 15] != null &&
                piece['side'] != board[index - 15]['side']) {
              move[index - 15] = Colors.redAccent;
            }
            if (board[index - 17] == null) {
              move[index - 17] = Colors.greenAccent;
            } else if (board[index - 17] != null &&
                piece['side'] != board[index - 17]['side']) {
              move[index - 17] = Colors.redAccent;
            }
          }
        }
        if (index + 2 <= 63 && (index - 7) % 8 != 0 && (index - 6) % 8 != 0) {
          if (index + 10 <= 63) {
            if (board[index + 10] == null) {
              move[index + 10] = Colors.greenAccent;
            } else if (board[index + 10] != null &&
                piece['side'] != board[index + 10]['side']) {
              move[index + 10] = Colors.redAccent;
            }
          }
          if (index - 6 >= 0) {
            if (board[index - 6] == null) {
              move[index - 6] = Colors.greenAccent;
            } else if (board[index - 6] != null &&
                piece['side'] != board[index - 6]['side']) {
              move[index - 6] = Colors.redAccent;
            }
          }
        }
        if (index - 2 >= 0 && index % 8 != 0 && (index - 1) % 8 != 0) {
          if (index + 6 <= 63) {
            if (board[index + 6] == null) {
              move[index + 6] = Colors.greenAccent;
            } else if (board[index + 6] != null &&
                piece['side'] != board[index + 6]['side']) {
              move[index + 6] = Colors.redAccent;
            }
          }
          if (index - 10 >= 0) {
            if (board[index - 10] == null) {
              move[index - 10] = Colors.greenAccent;
            } else if (board[index - 10] != null &&
                piece['side'] != board[index - 10]['side']) {
              move[index - 10] = Colors.redAccent;
            }
          }
        }
      }

      if (piece['pieceName'] == PieceName.bishop.name) {
        if (index % 8 == 0) {
          if (index + 9 <= 63) {
            board[index + 9] != null &&
                    board[index + 9]['side'] != piece['side']
                ? move[index + 9] = Colors.redAccent
                : board[index + 9] != null &&
                        board[index + 9]['side'] == piece['side']
                    ? null
                    : move[index + 9] = Colors.greenAccent;
          }
          if (index - 7 >= 0) {
            board[index - 7] != null &&
                    board[index - 7]['side'] != piece['side']
                ? move[index - 7] = Colors.redAccent
                : board[index - 7] != null &&
                        board[index - 7]['side'] == piece['side']
                    ? null
                    : move[index - 7] = Colors.greenAccent;
          }
        } else if ((index - 7) % 8 == 0) {
          if (index - 9 >= 0) {
            board[index - 9] != null &&
                    board[index - 9]['side'] != piece['side']
                ? move[index - 9] = Colors.redAccent
                : board[index - 9] != null &&
                        board[index - 9]['side'] == piece['side']
                    ? null
                    : move[index - 9] = Colors.greenAccent;
          }
          if (index + 7 <= 63) {
            board[index + 7] != null &&
                    board[index + 7]['side'] != piece['side']
                ? move[index + 7] = Colors.redAccent
                : board[index + 7] != null &&
                        board[index + 7]['side'] == piece['side']
                    ? null
                    : move[index + 7] = Colors.greenAccent;
          }
        } else {
          if (index + 9 <= 63) {
            board[index + 9] != null &&
                    board[index + 9]['side'] != piece['side']
                ? move[index + 9] = Colors.redAccent
                : board[index + 9] != null &&
                        board[index + 9]['side'] == piece['side']
                    ? null
                    : move[index + 9] = Colors.greenAccent;
          }
          if (index - 7 >= 0) {
            board[index - 7] != null &&
                    board[index - 7]['side'] != piece['side']
                ? move[index - 7] = Colors.redAccent
                : board[index - 7] != null &&
                        board[index - 7]['side'] == piece['side']
                    ? null
                    : move[index - 7] = Colors.greenAccent;
          }
          if (index - 9 >= 0) {
            board[index - 9] != null &&
                    board[index - 9]['side'] != piece['side']
                ? move[index - 9] = Colors.redAccent
                : board[index - 9] != null &&
                        board[index - 9]['side'] == piece['side']
                    ? null
                    : move[index - 9] = Colors.greenAccent;
          }
          if (index + 7 <= 63) {
            board[index + 7] != null &&
                    board[index + 7]['side'] != piece['side']
                ? move[index + 7] = Colors.redAccent
                : board[index + 7] != null &&
                        board[index + 7]['side'] == piece['side']
                    ? null
                    : move[index + 7] = Colors.greenAccent;
          }
        }
      }

      if (piece['pieceName'] == PieceName.queen.name) {
        if (piece['side'] == Side.black.name) {
          if (index % 8 == 0) {
            if (index - 7 >= 0) {
              board[index - 7] != null &&
                      board[index - 7]['side'] != piece['side']
                  ? move[index - 7] = Colors.redAccent
                  : board[index - 7] != null &&
                          board[index - 7]['side'] == piece['side']
                      ? null
                      : move[index - 7] = Colors.greenAccent;
            }
            if (index - 8 >= 0) {
              board[index - 8] != null &&
                      board[index - 8]['side'] != piece['side']
                  ? move[index - 8] = Colors.redAccent
                  : board[index - 8] != null &&
                          board[index - 8]['side'] == piece['side']
                      ? null
                      : move[index - 8] = Colors.greenAccent;
            }
            if (index + 9 <= 63) {
              board[index + 9] != null &&
                      board[index + 9]['side'] != piece['side']
                  ? move[index + 9] = Colors.redAccent
                  : board[index + 9] != null &&
                          board[index + 9]['side'] == piece['side']
                      ? null
                      : move[index + 9] = Colors.greenAccent;
            }
          } else if ((index - 7) % 8 == 0) {
            if (index - 8 >= 0) {
              board[index - 8] != null &&
                      board[index - 8]['side'] != piece['side']
                  ? move[index - 8] = Colors.redAccent
                  : board[index - 8] != null &&
                          board[index - 8]['side'] == piece['side']
                      ? null
                      : move[index - 8] = Colors.greenAccent;
            }
            if (index - 9 >= 0) {
              board[index - 9] != null &&
                      board[index - 9]['side'] != piece['side']
                  ? move[index - 9] = Colors.redAccent
                  : board[index - 9] != null &&
                          board[index - 9]['side'] == piece['side']
                      ? null
                      : move[index - 9] = Colors.greenAccent;
            }
            if (index + 7 <= 63) {
              board[index + 7] != null &&
                      board[index + 7]['side'] != piece['side']
                  ? move[index + 7] = Colors.redAccent
                  : board[index + 7] != null &&
                          board[index + 7]['side'] == piece['side']
                      ? null
                      : move[index + 7] = Colors.greenAccent;
            }
          } else {
            if (index - 7 >= 0) {
              board[index - 7] != null &&
                      board[index - 7]['side'] != piece['side']
                  ? move[index - 7] = Colors.redAccent
                  : board[index - 7] != null &&
                          board[index - 7]['side'] == piece['side']
                      ? null
                      : move[index - 7] = Colors.greenAccent;
            }
            if (index - 8 >= 0) {
              board[index - 8] != null &&
                      board[index - 8]['side'] != piece['side']
                  ? move[index - 8] = Colors.redAccent
                  : board[index - 8] != null &&
                          board[index - 8]['side'] == piece['side']
                      ? null
                      : move[index - 8] = Colors.greenAccent;
            }
            if (index - 9 >= 0) {
              board[index - 9] != null &&
                      board[index - 9]['side'] != piece['side']
                  ? move[index - 9] = Colors.redAccent
                  : board[index - 9] != null &&
                          board[index - 9]['side'] == piece['side']
                      ? null
                      : move[index - 9] = Colors.greenAccent;
            }
            if (index + 9 <= 63) {
              board[index + 9] != null &&
                      board[index + 9]['side'] != piece['side']
                  ? move[index + 9] = Colors.redAccent
                  : board[index + 9] != null &&
                          board[index + 9]['side'] == piece['side']
                      ? null
                      : move[index + 9] = Colors.greenAccent;
            }
            if (index + 7 <= 63) {
              board[index + 7] != null &&
                      board[index + 7]['side'] != piece['side']
                  ? move[index + 7] = Colors.redAccent
                  : board[index + 7] != null &&
                          board[index + 7]['side'] == piece['side']
                      ? null
                      : move[index + 7] = Colors.greenAccent;
            }
          }
        }
        if (piece['side'] == Side.white.name) {
          if (index % 8 == 0) {
            board[index + 8] != null &&
                    board[index + 8]['side'] != piece['side']
                ? move[index + 8] = Colors.redAccent
                : board[index + 8] != null &&
                        board[index + 8]['side'] == piece['side']
                    ? null
                    : move[index + 8] = Colors.greenAccent;
            if (index + 9 <= 63) {
              board[index + 9] != null &&
                      board[index + 9]['side'] != piece['side']
                  ? move[index + 9] = Colors.redAccent
                  : board[index + 9] != null &&
                          board[index + 9]['side'] == piece['side']
                      ? null
                      : move[index + 9] = Colors.greenAccent;
            }
            if (index - 7 >= 0) {
              board[index - 7] != null &&
                      board[index - 7]['side'] != piece['side']
                  ? move[index - 7] = Colors.redAccent
                  : board[index - 7] != null &&
                          board[index - 7]['side'] == piece['side']
                      ? null
                      : move[index - 7] = Colors.greenAccent;
            }
          } else if ((index - 7) % 8 == 0) {
            if (index + 7 <= 63) {
              board[index + 7] != null &&
                      board[index + 7]['side'] != piece['side']
                  ? move[index + 7] = Colors.redAccent
                  : board[index + 7] != null &&
                          board[index + 7]['side'] == piece['side']
                      ? null
                      : move[index + 7] = Colors.greenAccent;
            }
            board[index + 8] != null &&
                    board[index + 8]['side'] != piece['side']
                ? move[index + 8] = Colors.redAccent
                : board[index + 8] != null &&
                        board[index + 8]['side'] == piece['side']
                    ? null
                    : move[index + 8] = Colors.greenAccent;
            board[index - 9] != null &&
                    board[index - 9]['side'] != piece['side']
                ? move[index - 9] = Colors.redAccent
                : board[index - 9] != null &&
                        board[index - 9]['side'] == piece['side']
                    ? null
                    : move[index - 9] = Colors.greenAccent;
          } else {
            if (index + 7 <= 63) {
              board[index + 7] != null &&
                      board[index + 7]['side'] != piece['side']
                  ? move[index + 7] = Colors.redAccent
                  : board[index + 7] != null &&
                          board[index + 7]['side'] == piece['side']
                      ? null
                      : move[index + 7] = Colors.greenAccent;
            }
            if (index + 8 <= 63) {
              board[index + 8] != null &&
                      board[index + 8]['side'] != piece['side']
                  ? move[index + 8] = Colors.redAccent
                  : board[index + 8] != null &&
                          board[index + 8]['side'] == piece['side']
                      ? null
                      : move[index + 8] = Colors.greenAccent;
            }
            if (index + 9 <= 63) {
              board[index + 9] != null &&
                      board[index + 9]['side'] != piece['side']
                  ? move[index + 9] = Colors.redAccent
                  : board[index + 9] != null &&
                          board[index + 9]['side'] == piece['side']
                      ? null
                      : move[index + 9] = Colors.greenAccent;
            }
            if (index - 9 >= 0) {
              board[index - 9] != null &&
                      board[index - 9]['side'] != piece['side']
                  ? move[index - 9] = Colors.redAccent
                  : board[index - 9] != null &&
                          board[index - 9]['side'] == piece['side']
                      ? null
                      : move[index - 9] = Colors.greenAccent;
            }
            if (index - 7 >= 0) {
              board[index - 7] != null &&
                      board[index - 7]['side'] != piece['side']
                  ? move[index - 7] = Colors.redAccent
                  : board[index - 7] != null &&
                          board[index - 7]['side'] == piece['side']
                      ? null
                      : move[index - 7] = Colors.greenAccent;
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
                  Center(
                    child: Piece.getWidget(
                      board[index]['pieceName'],
                      board[index]['side'],
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
