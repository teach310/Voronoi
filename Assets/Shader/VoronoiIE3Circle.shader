Shader "Teach/VoronoiIE3Circle"
{
	Properties
	{
		_Value("Value", Float) = 1.0
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

			fixed4 frag (v2f i) : SV_Target
			{
				// 中心からの座標にする
				float2 r = 2.0 * (i.uv - 0.5);
				float aspectRatio = _ScreenParams.x / _ScreenParams.y;
				r.x *= aspectRatio;

				// 色
				fixed3 red = fixed3(1.0, 0.0, 0.0);
				fixed3 green = fixed3(0.0, 1.0, 0.0);
				fixed3 pixel;

				// 点
				float2 targetPoint;
				float minlen = 10;
                for(float i=0; i<2.0; i+= 0.1)
                {
                    float x = 0.2 * cos(_Time.y*_Value + i*PI);
                    float y = 0.2 * sin(_Time.y*_Value + i*PI);

                    float2 s = r - float2(x, y);
                    if(length(s) < minlen){
                    	targetPoint = float2(x,y);
                    	minlen = length(s);
                    }
                }

                pixel = fixed3((targetPoint.x+1.0)/2.0, (targetPoint.y+1.0)/2.0, 1.0);

				return fixed4(pixel, 1.0);
			}
			ENDCG
		}
	}
}
