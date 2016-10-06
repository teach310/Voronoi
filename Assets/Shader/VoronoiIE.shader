Shader "Teach/VoronoiIE"
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
				float2 point1 = float2(-0.3, 0.5);
				float2 point2 = float2(0.5, _Value);

				//point1のほうが近かったら赤，違ったら緑にする
				if(length(r - point1) < length(r - point2)){
					pixel = red;
				}else{
					pixel = green;
				}

				return fixed4(pixel, 1.0);
			}
			ENDCG
		}
	}
}
