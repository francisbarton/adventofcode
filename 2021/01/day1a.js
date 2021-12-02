import _ from 'lodash'
const fs = require('fs')


let fn = x => {
  let a = _.drop(_.range(x.length), 1)
  let b = a.map(i => x[i] > x[i - 1])
  return _.sum(b)
}

const ex = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
console.log(fn(ex))

const file_path = '2021/01/input1'

let depths = fs
.readFileSync(file_path)
.toString()
.split('\r\n')
.map(Number)
.slice(0, -1)

// check = 2000
console.log(depths.length)
console.log(fn(depths))

let fn2 = x => {
  let a = _.drop(_.range(x.length), 2)
  let b = a.map(i => x[i+1] > x[i-2])
  return _.sum(b)
}

console.log(fn2(ex))
console.log(fn2(depths))