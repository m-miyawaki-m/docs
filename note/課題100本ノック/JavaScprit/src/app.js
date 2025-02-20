function createCounter() {
    let count = 0; // 外部から直接変更できない変数

    return {
        increment: function() {
            count++;
            console.log("カウント:", count);
        },
        decrement: function() {
            count--;
            console.log("カウント:", count);
        },
        getCount: function() {
            return count;
        }
    };
}

const counter = createCounter();
counter.increment(); // カウント: 1
counter.increment(); // カウント: 2
console.log(counter.getCount()); // 2
counter.decrement(); // カウント: 1