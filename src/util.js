export function compact(array) {
  if (!Array.isArray(array)) {
    return [];
  }

  return array.filter((v) => v !== undefined);
}
