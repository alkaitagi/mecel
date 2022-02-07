import 'package:flutter/material.dart';
import 'package:wordle/modules/game/utils.dart';
import 'package:wordle/shared/models/game_state.dart';
import 'package:wordle/shared/snackbar.dart';

class ShareButton extends StatelessWidget {
  const ShareButton(
    this.game, {
    Key? key,
  }) : super(key: key);

  final GameState game;

  String getSharingText() {
    var text = 'Mecel ${getCurrentDay() + 1}'
        ' • ${game.config.language.nativeName} • '
        '${game.attempts.length}/${game.maxAttempts}\n';

    final word = game.word;
    for (final attempt in game.attempts) {
      text += '\n';
      for (var i = 0; i < word.length && i < attempt.length; i++) {
        if (attempt[i] == word[i]) {
          text += '🟩';
        } else if (word.contains(attempt[i])) {
          text += '🟨';
        } else {
          text += '⬜';
        }
      }
    }
    return text;
  }

  Future<void> share(BuildContext context) async {
    final text = getSharingText();
    await copyText(context, text);
    showSnackbar(
      context,
      icon: Icons.content_copy_rounded,
      text: 'Чин къачуна',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => share(context),
      label: const Text('Паюн'),
      icon: const Icon(Icons.share_rounded),
    );
  }
}