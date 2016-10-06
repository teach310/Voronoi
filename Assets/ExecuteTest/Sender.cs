using UnityEngine;
using System.Collections;
using UnityEngine.EventSystems; //必須

public class Sender : MonoBehaviour {

	public GameObject targetObj;

	void Update(){
		if (Input.GetKeyDown (KeyCode.A)) {


			// 対象オブジェクトがITestHandlerを継承していたら．
			if (ExecuteEvents.CanHandleEvent<ITestHandler> (targetObj)) {
				//対象ゲームオブジェクトのメソッドを実行
				//Execute(GameObject obj, BaseEventData ev, ExecuteEvents.EventFunction<T> fuctor)
				ExecuteEvents.Execute<ITestHandler> (
					targetObj, 
					null, 
					(handler, eventData) => handler.OnRecieve ("Recieve")
				);
			}



		}
	}
}
