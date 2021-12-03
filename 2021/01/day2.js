// --- Day 2: Dive! ---

// Now, you need to figure out how to pilot this thing. It seems like the submarine can take a series of commands like forward 1, down 2, or up 3:

//     forward X increases the horizontal position by X units.
//     down X increases the depth by X units.
//     up X decreases the depth by X units.

// Note that since you're on a submarine, down and up affect your depth, and so they have the opposite result of what you might expect.

// Calculate the horizontal position and depth you would have after following the planned course. What do you get if you multiply your final horizontal position by your final depth?

import fs from 'fs'
// import { flatMap } from 'lodash'
import { flow, filter, startsWith, map, sum } from 'lodash/fp'


let filter_by = (arr, dir) => {
  return flow(
    filter(startsWith(dir)),
    map(x => x.match(/\d+$/g)),
    map(Number),
    sum
    )(arr)
}

const ex = ['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']
map(['forward', 'up', 'down'], x => filter_by(ex, x)) // why does this not work?
let dirs = ['forward', 'up', 'down']
let res = dirs.map(x => filter_by(ex, x)) //?
let horiz = res[0]
let depth = res[2] - res[1] 
horiz*depth //?


const file_path = '2021/01/input2'

let commands = fs
.readFileSync(file_path)
.toString()
.split('\r\n')

// checks
commands.length //?
commands[0] //?

let res2 = dirs.map(x => filter_by(commands, x)) //?
let horiz2 = res2[0]
let depth2 = res2[2] - res2[1] 
horiz2*depth2 //?


const part2 = (arr) =>{
  let h = 0, d = 0, aim = 0
  arr.map(line => {
    let cur = line.split(' ')
    let amt = parseInt(cur[1])
    switch(cur[0]) {
      case 'up': aim -= amt; break;
      case 'down': aim += amt; break;
      case 'forward': { h += amt; d += amt*aim; }; break;
    };
  })
  return h*d
}

part2(ex) //?
part2(commands) //?



// let keys = flatMap(ex, value => value.match(/^\w+/)) //?
// let values = flatMap(ex, value => value.match(/\d+$/).map(Number)) //?

// https://stackoverflow.com/a/39128144/5168907
// let result = {};
// keys.forEach((key, i) => result[key] = values[i])
// result = Object.assign(...keys.map((k, i) => ({[k]: values[i]})))
// result = keys.reduce((o, k, i) => ({...o, [k]: values[i]}), {})
// result = Object.fromEntries(keys.map((_, i) => [keys[i], values[i]]))
// result //?

// https://stackoverflow.com/a/67151933/5168907
// const result = Object.fromEntries(
//   keys.map((e, i) => ([e, values[i]]))
// )







// let out = ex.map(x => x.split(" "))

// flow(
// _.filter(ex, value => value.match(/^forward/))
// _.flatMap(value => value.match(/\d+$/).map(Number))
// ) //?



// let out = [keys] = values //?

// let create_map = (keys, values) => {
//   let x = _.map(keys)
//   return x
// }

// create_map(keys, values) //?


// let newarr = _.zipObject(keys, values) //?
// let newarr = _.zipWith(keys, values) //?
// let newarr = _.zip(keys, values) //?
// let out = Object.fromEntries(Object.entries(newarr)) //?
// let out = Object.fromEntries(newarr) //?
// _.groupBy(out)
// _.map(out, key => key)

// _.mapValues(newarr, 'forward') //?

// let forward = _.filter(newarr) //?

// _.groupBy(commands, _.trimEnd(_.range(10))) //?
// _.groupBy(ex, _.trimEnd(_, _.range(10))) //?
