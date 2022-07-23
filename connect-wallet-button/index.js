
const getWeb3 = async () => {
    
    return new Promise(async (resolve, reject) => {
        const web3 = new Web3(window.ethereum)

        try{
            await window.ethereum.request({method: "eth_requestAccounts"})
            resolve(web3)
        }
        catch(error){
            reject(error)
        }
    })

}

document.addEventListener("DOMContentLoaded", () => {

    document.getElementById("connect-wallet-button").addEventListener("click", async () => {
        const web3 = await getWeb3()

        const walletAdd = await web3.eth.requestAccounts()
        const walletWeiBalance = await web3.eth.getBalance(walletAdd[0])
        const walletEthBalance = Math.round(Web3.utils.fromWei(walletWeiBalance)*1000)/1000
    
        document.getElementById("wallet-address").innerText = walletAdd
        document.getElementById("wallet-balance").innerText = walletEthBalance
        
    });

})
