#ifndef INCLUDE_COLOR_MAP_HLSL
#define INCLUDE_COLOR_MAP_HLSL

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
sampler2D _ColorMap;
float _RotateAngle;
float _FlipX;
float _FlipY;

v2f vert_rotate(appdata v)
{
    v2f o = (v2f) 0;
    o.vertex = UnityObjectToClipPos(v.vertex);
    float2 uv = v.uv - 0.5;
    float ang2Rad = 3.14159 / 180;
    float rad = ang2Rad * _RotateAngle;
    float sinTheta = sin(rad);
    float cosTheta = cos(rad);
    float2x2 rotateMatrix = float2x2(float2(cosTheta,-sinTheta),float2(sinTheta,cosTheta));
    uv = mul(rotateMatrix,uv);
    uv += 0.5;
    o.uv = uv;
    return o;
}

fixed4 frag_rotate (v2f i) : SV_Target
{
    float4 col = tex2D(_ColorMap, i.uv);
    return col;                
}


v2f vert_flip(appdata v)
{
    v2f o = (v2f) 0;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = v.uv;
    return o;
}

fixed4 frag_flip (v2f i) : SV_Target
{
    float2 uv =  float2(i.uv.x * (1-_FlipX) + (1-i.uv.x) * _FlipX, i.uv.y * (1 - _FlipY) + (1-i.uv.y) * _FlipY);
    float4 col = tex2D(_ColorMap, uv);
    return col;                

}

#endif