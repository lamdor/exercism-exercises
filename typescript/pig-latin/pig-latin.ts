// If a word begins with a vowel, or starts with `"xr"` or `"yt"`, add an `"ay"` sound to the end of the word.
const rule1Regexp = /^(?<keep>[aeiou]|xr|yt)(?<move>.+)/;

// If a word begins with a one or more consonants, first move those consonants to the end of the word and then add an `"ay"` sound to the end of the word.
const rule2Regexp = /^(?<move>[^aeiou]+)(?<keep>.+)/;

// If a word starts with zero or more consonants followed by `"qu"`, first move those consonants (if any) and the `"qu"` part to the end of the word, and then add an `"ay"` sound to the end of the word.
const rule3Regexp = /^(?<move>[^aeiou]*qu)(?<keep>.+)/;

// If a word starts with one or more consonants followed by `"y"`, first move the consonants preceding the `"y"`to the end of the word, and then add an `"ay"` sound to the end of the word.
// no regexp needed

export function translate(str: string): string {
  return str.split(/\s+/).map(translate_word).join(" ");
}

export function translate_word(str: string): string {
  return (
    apply_regexp_rule(rule1Regexp, str) ||
    apply_regexp_rule(rule3Regexp, str) ||
    apply_regexp_rule(rule2Regexp, str) ||
    "" // should not get here
  );
}

function apply_regexp_rule(rule: RegExp, str: string): string | undefined {
  let match = rule.exec(str);
  if (match && match.groups) {
    let groups = match.groups;
    if (groups.keep && groups.move) {
      return groups.keep + groups.move + "ay";
    }
  }
}
