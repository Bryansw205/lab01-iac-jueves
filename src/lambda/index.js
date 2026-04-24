const url = "https://aws.amazon.com/";

export const handler = async(event) => {
    try {
        const res = await fetch(url);
        console.info("Bryan Mariños", res.status);
        return res.status;
    }
    catch (e) {
        console.error(e);
        return 500;
    }
};