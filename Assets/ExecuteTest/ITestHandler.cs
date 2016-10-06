using UnityEngine.EventSystems; //必須

// IEventSystemHandlerを継承させる
public interface ITestHandler : IEventSystemHandler{
	void OnRecieve(string str); //受け取るメソッドを定義
}
