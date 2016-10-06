using UnityEngine;
using System.Collections;

public class sinTest : MonoBehaviour {

	public float height = 5f;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		this.transform.position = new Vector3 (Mathf.Cos(Time.time)* height,Mathf.Sin(Time.time) * height, 0);
	}
}
