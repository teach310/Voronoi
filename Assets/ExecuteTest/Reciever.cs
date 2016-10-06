using UnityEngine;
using System.Collections;

public class Reciever : MonoBehaviour, ITestHandler {

	// publicにする
	public void OnRecieve(string str){
		Debug.Log (string.Format("{0} : {1}",this.gameObject.name, str));
	}
}
