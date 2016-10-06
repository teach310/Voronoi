using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class Voronoi1 : MonoBehaviour {

	public Material mat;

	void OnRenderImage(RenderTexture src, RenderTexture dest){
		Graphics.Blit (src, dest, mat);
	}
}
