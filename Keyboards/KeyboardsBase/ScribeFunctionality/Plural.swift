//
//  Plural.swift
//
//  Functions that control the plural command.
//

import UIKit

/// Inserts the plural of a valid noun in the command bar into the proxy.
///
/// - Parameters
///   - commandBar: the command bar into which an input was entered.
func queryPlural(commandBar: UILabel) {
  // Cancel via a return press.
  if commandBar.text! == pluralPromptAndCursor {
    return
  }
  var noun: String = (commandBar.text!.substring(
    with: pluralPrompt.count..<((commandBar.text!.count) - 1))
  )
  noun = String(noun.trailingSpacesTrimmed)

  // Check to see if the input was uppercase to return an uppercase plural.
  inputWordIsCapitalized = false
  if !languagesWithCapitalizedNouns.contains(controllerLanguage) {
    let firstLetter = noun.substring(toIdx: 1)
    inputWordIsCapitalized = firstLetter.isUppercase
    noun = noun.lowercased()
  }
  let nounInDirectory = nouns?[noun] != nil
  if nounInDirectory {
    if nouns?[noun]?["plural"] as? String != "isPlural" {
      guard let plural = nouns?[noun]?["plural"] as? String else { return }
      if inputWordIsCapitalized == false {
        proxy.insertText(plural + " ")
      } else {
        proxy.insertText(plural.capitalized + " ")
      }
    } else {
      proxy.insertText(noun + " ")
      commandBar.text = commandPromptSpacing + "Already plural"
      invalidState = true
      isAlreadyPluralState = true
    }
  } else {
    invalidState = true
  }
}
