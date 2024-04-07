export function valid(digitString: string): boolean {
  let digitCount = 0;
  let acc = 0;

  for (let index = digitString.length - 1; index >= 0; index--) {
    const c = digitString[index];

    if (c == " ") {
      continue;
    }

    let digit = parseInt(c);
    if (Number.isNaN(digit)) {
      return false;
    }

    digitCount += 1;

    if (digitCount % 2 == 0) {
      if (digit >= 5) {
        acc += 2 * digit - 9;
      } else {
        acc += 2 * digit;
      }
    } else {
      acc += digit;
    }
  }

  return digitCount > 1 && acc % 10 == 0;
}
