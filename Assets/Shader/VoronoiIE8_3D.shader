Shader "Teach/VoronoiIE8_3D"
{
	Properties
	{
		_CCount("Circle Count", Int) = 1
		_Value("Value", Float) = 1.0
		_ColStrength("Shadow Color Strength", Range(-1.0, 1.0)) = 0.0
		_ShadowStrength("Shadow Strength", Float) = 1.0
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always


		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#define PI 3.14159
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			float _Value;
			float _ColStrength;
			int _CCount;
			uniform float4 _MousePos;
			float _ShadowStrength;

			fixed4 frag (v2f i) : SV_Target
			{
				// 中心からの座標にする
				float2 r = 2.0 * (i.uv - 0.5);
				float aspectRatio = _ScreenParams.x / _ScreenParams.y;
				r.x *= aspectRatio;

				// 色
				fixed3 pixel;

				// 点
				float2 targetPoint;
				float2 secondPoint;

				float minlen = 10;
				float secondMinLen = 11;

				float amp = 0.5;

				for(float j = 0; j< _CCount; j++){
	                for(float i=0; i<2.0; i+= 0.1)
	                {
	                	
	                    float x = j*0.2 * cos(_Time.y*_Value + i*PI);
	                    float y = j*0.2 * sin(_Time.y*_Value + i*PI);

	                    float2 s = r - float2(x, y);
	                    if(length(s) < minlen){
	                    	secondPoint = targetPoint;
	                    	targetPoint = float2(x,y);
	                    	secondMinLen = minlen;
	                    	minlen = length(s);
	                    }

	                    else if(length(s) < secondMinLen && length(s) >= minlen){
	                    	secondPoint = float2(x,y);
	                    	secondMinLen = length(s);
	                    }
	                }
                }


                float shadowWidth = _Value;
                float dLen = secondMinLen - minlen;

                if(dLen < shadowWidth){
                	fixed3 colMain = fixed3((targetPoint.x+1.0)/2.0, (targetPoint.y+1.0)/2.0, 1.0);
                	fixed3 colSub = fixed3((secondPoint.x+1.0)/2.0, (secondPoint.y+1.0)/2.0, 1.0);

                	// [0->1]
                	float rate = (shadowWidth - dLen)/shadowWidth;
                	
                	//k:[1.0 -> 0.x]
                	float k = lerp(1.0, _ColStrength, smoothstep(0.0, 1.0, rate));

                	pixel = colMain * k;
                }else{
                	
                	pixel = fixed3((targetPoint.x+1.0)/2.0, (targetPoint.y+1.0)/2.0, 1.0);
                }
                fixed3 shadow = fixed3(length(r), length(r), length(r)) * _ShadowStrength;
                pixel -= shadow;


				return fixed4(pixel, 1.0);
			}
			ENDCG
		}
	}
}
