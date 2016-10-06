using UnityEngine;
using System.Collections;


[ExecuteInEditMode]
public class VoronoiMouseInput : MonoBehaviour {

	public Material mat;
	public bool onMouse;
	private Vector2 mousePos;
	 
	void Update(){
		GetMousePosition ();
		Debug.Log (mousePos);
	}

	void GetMousePosition(){
		mousePos = new Vector2( Input.mousePosition.x / Screen.width, Input.mousePosition.y / Screen.height);
		mousePos = 2.0f * (mousePos - Vector2.one * 0.5f);
	}

	void OnRenderImage(RenderTexture src, RenderTexture dest){
		if(onMouse)
			mat.SetVector ("_MousePos", mousePos);
		Graphics.Blit (src, dest, mat);
	}
}
