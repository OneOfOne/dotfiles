const fn = (k) => `["down", "KC_${k}"], ["delay", 25], ["up", "KC_${k}"], ["delay", 25]`;
const m = ['["down", "KC_LCTRL"], ["delay", 25]'];
for (const k of process.argv.slice(2).concat('').join('')) m.push(fn(k.toUpperCase()));
m.push('["up", "KC_LCTRL"]');

console.log(`[\n\t${m.join(',\n\t')}\n]`);
