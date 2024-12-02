// node requires 100M @1mio less memory with util.promisify
const { promisify } = require("node:util");
const delay = promisify(setTimeout);

async function runTasks(numTasks) {
  const tasks = [];

  for (let i = 0; i < numTasks; i++) {
    tasks.push(delay(10000));
  }

  await Promise.all(tasks);

  console.log("All tasks completed");
}

const numTasks = parseInt(process.argv[2]) || 10000;

runTasks(numTasks).catch((err) => {
  console.error("Error:", err);
});
