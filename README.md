[简体中文](docs/Readme_zh-cn.md)
# Word Dictation and Correction

A small program that allows dictation of words and dictation of mispronounced words for rewriting.


![Main](/image/main.jpeg)

# Notice
**This program currently does not save words, and if you close the program, all words will be lost. So please make sure to import as many words as you can remember at a time.**

# Usage

## Configuration

You can select a series of words to correct, using the following English word sequence as an example (these words are copied from Excel, while this program is not limited to English, as long as your TTS supports it, then you can dictate)

```text
insurance	保险
hostel	青年旅社
qualifications	资格
```
![](/image/1.jpeg)
First, follow the prompts and click the icon in the upper right corner to import the words.



![](/image/2.jpeg)

Among them, you should enter words and meanings in Input word and meanings (of course this can be set according to personal preference, you can also set it to words and phonetic symbols, as long as it meets the format of `Text + Separator + Text`). For words copied from Excel, the separator is generally Tab, so you can select Tab as the separator in the program.

The currently supported separators are: Tab, space, comma, semicolon.

| Separator | Character |
|-----------|-----------|
| Tab       | `\t`      |
| Space     | ` `       |
| Comma     | `,`       |
| Semicolon | `;`       |

If it shows `No TTS language found, maybe TTS engine blocked by system`, it means your system doesn't support TTS, or you don't have TTS engine installed. It is recommended that you install Google TTS engine, otherwise it may not work (currently Android 13 system has a conflict with the TTS driver system currently installed in this software, so it cannot be used). The current default language is `en-GB`, which is British English.

Below you can choose the mode, where `Correction mode` means to do wrong word dictation and `Dictation mode` means to do word dictation. When you select `Correction mode`, you need to fill in how many times you need to write, while `Dictation mode` does not.

After you click Save, you will jump back to the main screen, and you can start dictating now.

## Correction step details

![](/image/3.jpeg)

The program plays the word pronunciation after each confirmation of input, or you can click on the word and it will be pronounced. The number above the word indicates how many more times it needs to be written, and when it is finished, it will automatically jump to the next word. After each word is written, you can use the Enter key to submit it. When a spelling error is made, the error will be indicated and the remaining times will not be deducted.

### Special feature of error correction mode -- blurring words until they are wrong

![](/image/6.jpeg)
When you select `Correction mode` in the settings screen, and `Blur words until input error` is selected in `Correction mode`, the words will be blurred until you make an input error by default in the correction mode. When you type correctly, the words will be blurred again until the next input error.


## Word dictation step details
![](/image/4.jpeg)

The program plays the word pronunciation after each confirmation of input, and you can also pronounce it by clicking the pronunciation button above. After each word is written, you can use the Enter key to submit it. When a spelling error is made, it will indicate the error. When all words are written, an interface will pop up to show you the words that are misspelled.

## Favorites mode details
![](/image/5.jpeg)

When you are correcting or dictating, you can type "..." (three dots) in the input box, and the current word will be added to your favorites. You can click the ⭐ icon in the upper right corner of the main screen, and you will enter the Favorites screen.