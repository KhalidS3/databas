/**
 * A sample of a main function stating the famous Hello World.
 *
 * @returns void
 * @author Khalid Safi
 */

function main() {
    // console.log("Hello World");

    // for (let i = 0; i < 9; i++) {
    //     console.log(i);
    // }

    // let a = 1;
    // let b = a + 1;

    // console.log("\n", a, b);

    let a = 1;
    let b;
    let range = "";

    b = a + 1;

    for (let i = 0; i < 9; i++) {
        range += i + ", ";
    }

    console.info("\nHello World");
    console.info(range.substring(0, range.length - 2));
    console.info(a, b);
}

main();
