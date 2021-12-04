// --- Day 3: Binary Diagnostic ---

// The submarine has been making some odd creaking noises, so you ask it to produce a diagnostic report just in case.

// The diagnostic report (your puzzle input) consists of a list of binary numbers which, when decoded properly, can tell you many useful things about the conditions of the submarine. The first parameter to check is the power consumption.

// You need to use the binary numbers in the diagnostic report to generate two new binary numbers (called the gamma rate and the epsilon rate). The power consumption can then be found by multiplying the gamma rate by the epsilon rate.

// Each bit in the gamma rate can be determined by finding the most common bit in the corresponding position of all numbers in the diagnostic report.

// The epsilon rate is calculated in a similar way; rather than use the most common bit, the least common bit from each position is used.

import fs from 'fs'
import _ from 'lodash'
import {flow, map, sum} from 'lodash/fp'

const ex = [
  '00100',  // 4
  '11110',  // 30
  '10110',  // 22
  '10111',  // 23
  '10101',  // 21
  '01111',  // 15
  '00111',  // 7
  '11100',  // 28
  '10000',  // 16
  '11001',  // 25
  '00010',  // 2
  '01010'   // 10
]

// Part 1

const file_path = '2021/01/input3'

let codes = fs
.readFileSync(file_path)
.toString()
.split('\r\n')

// checks
codes.length //?
codes[0] //?

let digits = codes[0].length //?

let sums = (arr, y) => {
  return flow(
    map(x => x[y]),
    map(Number),
    sum
  )(arr)
}

let test = _.range(digits).map(x => sums(codes, x))
.map(x => x > codes.length/2)

let out = test.map(x => {
switch (x) {
  case true: return 1;
  default: return 0;
}})
let a = parseInt(out.join(''), 2)

// multiply a by its inverse
a * ((2 ** digits - 1) - a) //?




// Part 2

// Next, you should verify the life support rating, which can be determined by multiplying the oxygen generator rating by the CO2 scrubber rating.

// Both the oxygen generator rating and the CO2 scrubber rating are values that can be found in your diagnostic report - finding them is the tricky part. Both values are located using a similar process that involves filtering out values until only one remains. Before searching for either rating value, start with the full list of binary numbers from your diagnostic report and consider just the first bit of those numbers. Then:

//     Keep only numbers selected by the bit criteria for the type of rating value for which you are searching. Discard numbers which do not match the bit criteria.
//     If you only have one number left, stop; this is the rating value for which you are searching.
//     Otherwise, repeat the process, considering the next bit to the right.

// The bit criteria depends on which type of rating value you want to find:

//     To find oxygen generator rating, determine the most common value (0 or 1) in the current bit position, and keep only numbers with that bit in that position. If 0 and 1 are equally common, keep values with a 1 in the position being considered.
//     To find CO2 scrubber rating, determine the least common value (0 or 1) in the current bit position, and keep only numbers with that bit in that position. If 0 and 1 are equally common, keep values with a 0 in the position being considered.



// const oxygen_rating = (digit, arr, cutoff) => {
//   if (arr.length == 1) {
//     return arr
//   } else {
//   // returns 2 for n == 2|3; 3 for n == 4|5; 4 for n == 5|6 etc
//   let test_index = Math.ceil((arr.length + 1)/2) - 1

//   let test = arr[test_index] >= cutoff
//   digit -= 1 
//   switch (test) {
//     case true:
//       var new_arr = arr.filter(value => value >= cutoff)
//       cutoff += 2**digit
//       break
//     case false:
//       var new_arr = arr.filter(value => value < cutoff)
//       cutoff -= 2**digit
//   }
//   return oxygen_rating(digit, new_arr, cutoff)
//   }
// }

// const carbon_rating = (digit, arr, cutoff) => {
//   if (arr.length == 1) {
//     return arr
//   } else {
//   // returns 2 for n == 2|3; 3 for n == 4|5; 4 for n == 5|6 etc
//   let test_index = Math.ceil((arr.length + 1)/2) - 1

//   let test = arr[test_index] >= cutoff
//   digit -= 1 
//   switch (test) {
//     case true:
//       var new_arr = arr.filter(value => value < cutoff)
//       cutoff -= 2**digit
//       break
//     case false:
//       var new_arr = arr.filter(value => value >= cutoff)
//       cutoff += 2**digit
//   }
//   return carbon_rating(digit, new_arr, cutoff)
//   }
// }

// unify above into a single function
const return_rating = (digit, arr, cutoff, type) => {
  if (arr.length == 1) {
    return arr
  } else {
  // returns 2 for n == 2|3; 3 for n == 4|5; 4 for n == 5|6 etc
  let test_index = Math.ceil((arr.length + 1)/2) - 1

  let test = arr[test_index] >= cutoff
  digit -= 1 
  switch (true) {
    case ((type == 'oxygen' && test === true) || (type == 'carbon' && test == false)): 
      var new_arr = arr.filter(value => value >= cutoff)
      cutoff += 2**digit
      break
    case ((type == 'carbon' && test === true) || (type == 'oxygen' && test == false)): 
      var new_arr = arr.filter(value => value < cutoff)
      cutoff -= 2**digit
    }
  return return_rating(digit, new_arr, cutoff, type)
  }
}

// let cols = ex[0].length //?
let ex_sorted = ex.map(x => parseInt(x, 2)).sort((a, b) => {return a - b}) //?
// let cutoff = 2**(cols - 1) //?
// oxygen_rating(4, ex_sorted, 2**4) //?
// carbon_rating(4, ex_sorted, 2**4) //?
return_rating(4, ex_sorted, 2**4, 'oxygen') //?
return_rating(4, ex_sorted, 2**4, 'carbon') //?


const process_arr = (arr) => {
  let cols = arr[0].length
  let init_digit = cols - 1
  let arr_sorted = arr.map(x => parseInt(x, 2)).sort((a, b) => {return a - b})
  let oxy = return_rating(init_digit, arr_sorted, 2**init_digit, 'oxygen')
  let coo = return_rating(init_digit, arr_sorted, 2**init_digit, 'carbon')
  return oxy*coo
}
process_arr(ex) //?
process_arr(codes) //?