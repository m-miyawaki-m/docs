const uniqueNumbers = new Set([1, 2, 2, 3, 3, 4]);
console.log([...uniqueNumbers]); // [1, 2, 3, 4]
console.log([uniqueNumbers]);

for (const num of uniqueNumbers) {
    console.log(num); // 1, 2, 3, 4
}
