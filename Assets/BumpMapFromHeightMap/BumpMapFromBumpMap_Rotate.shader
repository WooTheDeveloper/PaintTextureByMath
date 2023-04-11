Shader "Unlit/BumpMapFromBumpMap_Rotate"
{
    Properties
    {
        _BumpMap ("_BumpMap", 2D) = "bump" {}
        _RotateAngle("_RotateAngle", range(0,360)) = 0        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
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
                float4 rotateMatrix : TEXCOORD1;
                float4 inverseRotateMatrix : TEXCOORD2;
            };
            
            sampler2D _BumpMap;
            float4 _BumpMap_TexelSize;
            float _RotateAngle;
            
            v2f vert(appdata v)
            {
                v2f o = (v2f) 0;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                float ang2Rad = 3.14159 / 180;
                float rad = ang2Rad * _RotateAngle;
                float sinTheta = sin(rad);
                float cosTheta = cos(rad);
                o.rotateMatrix = float4(float2(cosTheta,-sinTheta),float2(sinTheta,cosTheta));
                o.inverseRotateMatrix = float4(float2(cosTheta,sinTheta),float2(-sinTheta,cosTheta));
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv - 0.5;
                float2x2 rotateMatrix = float2x2(i.rotateMatrix.xy,i.rotateMatrix.zw); 
                uv = mul(rotateMatrix,uv);  //假设theta大于0，上述的矩阵搭建方式和右乘操作会让uv发生逆时针旋转，而团图案看上去则是发生了顺时针旋转
                uv += 0.5;
                float4 col = tex2D(_BumpMap, uv);

                float2 xy = col.xy;
                xy = xy * 2 - 1;
                xy = mul(float2x2(i.inverseRotateMatrix.xy,i.inverseRotateMatrix.zw),xy); // 由于看上去是发生了顺时针旋转，所以它的法线方向真的得发生顺时针旋转，哈哈哈哈
                xy = xy * 0.5 + 0.5;
                col.rg = xy; 
                
                return col;                
            
            }
            
            ENDCG
        }
        
    }
}
