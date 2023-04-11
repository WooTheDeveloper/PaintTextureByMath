#ifndef INCLUDE_FLOWMAP_HLSL
#define INCLUDE_FLOWMAP_HLSL
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

float _DistanceFadePow;

v2f vert (appdata v)
{
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = v.uv;
    return o;
}

fixed4 frag_scatter (v2f i) : SV_Target
{
    float2 dir = i.uv.xy - float2(0.5,0.5);
    float dist = length(dir);
    
    dir = normalize(dir);
    dir *= saturate( cos(dist * _DistanceFadePow));
    dir = dir * 0.5 + 0.5;
    
    float4 col = float4(dir,0,1) ;
    return col;
}

fixed4 frag_gather (v2f i) : SV_Target
{
    float2 dir =   float2(0.5,0.5) - i.uv.xy;
    float dist = length(dir);
    
    dir = normalize(dir);
    dir *= saturate( cos(dist * _DistanceFadePow));
    dir = dir * 0.5 + 0.5;
    
    float4 col = float4(dir,0,1) ;
    return col;
}

#endif