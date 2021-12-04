// --- Day 1: Sonar Sweep ---

// You're minding your own business on a ship at sea when the overboard alarm goes off! You rush to see if you can help. Apparently, one of the Elves tripped and accidentally sent the sleigh keys flying into the ocean!

// Before you know it, you're inside a submarine the Elves keep ready for situations like this. It's covered in Christmas lights (because of course it is), and it even has an experimental antenna that should be able to track the keys if you can boost its signal strength high enough; there's a little meter that indicates the antenna's signal strength by displaying 0-50 stars.

// As the submarine drops below the surface of the ocean, it automatically performs a sonar sweep of the nearby sea floor. On a small screen, the sonar sweep report (your puzzle input) appears: each line is a measurement of the sea floor depth as the sweep looks further and further away from the submarine.

// The first order of business is to figure out how quickly the depth increases, just so you know what you're dealing with - you never know if the keys will get carried into deeper water by an ocean current or a fish or something.

// To do this, count the number of times a depth measurement increases from the previous measurement. (There is no measurement before the first measurement.)


import _ from 'lodash'
import fs from 'fs'


let fn = x => {
  let a = _.drop(_.range(x.length), 1)
  let b = a.map(i => x[i] > x[i - 1])
  return _.sum(b)
}

// create array for example measurements
const ex = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
console.log(fn(ex))

const file_path = '2021/01/input1'

let depths = fs
.readFileSync(file_path)
.toString()
.split('\r\n')
// .map(Number)
.map(_.parseInt)

// check = 2000
console.log(depths.length)
console.log(fn(depths))


// Considering every single measurement isn't as useful as you expected: there's just too much noise in the data.

// Instead, consider sums of a three-measurement sliding window.  Your goal now is to count the number of times the sum of measurements in this sliding window increases from the previous sum. 


let fn2 = x => {
  let a = _.drop(_.range(x.length), 2)
  let b = a.map(i => x[i+1] > x[i-2])
  return _.sum(b)
}

console.log(fn2(ex))
console.log(fn2(depths))