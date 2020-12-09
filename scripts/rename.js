const fs = require('fs');

if (process.argv.length < 4) {
  console.log('usage: rename.js <regex> <replacement> [-f]');
  return;
}

const dryRun = !(process.argv.length > 4 && process.argv[4] === '-f');
console.log('dryRun: ' + dryRun);

const regex = process.argv[2];
console.log('regex: ' + regex);
const replacement = process.argv[3];
console.log('replacement: ' + replacement);

for (const filename of fs.readdirSync(process.cwd())) {
  const newFilename = filename.replace(RegExp(regex), replacement);
  console.log(`"${filename}" -> "${newFilename}"`);
  if (!dryRun)
    fs.renameSync(filename, newFilename);
}
