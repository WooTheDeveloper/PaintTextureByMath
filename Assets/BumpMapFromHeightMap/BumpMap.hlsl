#ifndef INCLUDE_BUMP_MAP_HLSL
#define INCLUDE_BUMP_MAP_HLSL

struct appdata
{
    float4 vertex : POSITION;
    float2 uv : TEXCOORD0;
};

struct v2f
{
    float2 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
    float4 inverseRotate : TEXCOORD1;
};

sampler2D _HeightMap;
float4 _HeightMap_ST;
float4 _HeightMap_TexelSize;
float _BumpScale;
float _RealScopeSize;
float _RotateAngle;

v2f vert (appdata v)
{
    v2f o = (v2f) 0;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = v.uv;
    return o;
}

fixed4 frag (v2f i) : SV_Target
{
    float col = tex2D(_HeightMap, i.uv).g;
   
    float col_x = tex2D(_HeightMap,i.uv + float2( _HeightMap_TexelSize.x,0)).g;
    float dhx = (col_x - col) * _BumpScale ; 
    float dx = 1;

    float col_y = tex2D(_HeightMap,i.uv + float2( 0,_HeightMap_TexelSize.y)).g;
    float dhy = (col_y - col) * _BumpScale;
    float dy = 1;
    
    float3 ddx = float3(dx,0,dhx);
    float3 ddy = float3(0,dy,dhy);
    float3 normal = cross(ddx,ddy);
    
    normal = normalize(normal);
    normal = normal * 0.5 + 0.5;
    return float4(normal,1);                

}

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
    float4 inverseRotate = float4(float2(cosTheta,sinTheta),float2(-sinTheta,cosTheta));
    o.inverseRotate = inverseRotate;
    return o;
}

fixed4 frag_rotate (v2f i) : SV_Target
{
    float col = tex2D(_HeightMap, i.uv).g;
    float2x2 inverseRotate = float2x2(i.inverseRotate.xy,i.inverseRotate.zw);
    
    float2 duvx = float2( _HeightMap_TexelSize.x,0);
    duvx = mul(duvx,inverseRotate);
    float col_x = tex2D(_HeightMap,i.uv + duvx).g;
    float dhx = (col_x - col) * _BumpScale ; 
    float dx = 1;
    float2 duvy = float2( 0,_HeightMap_TexelSize.y);
    duvy = mul(duvy,inverseRotate);
    float col_y = tex2D(_HeightMap,i.uv + duvy).g;
    float dhy = (col_y - col) * _BumpScale;
    float dy = 1;
    
    float3 ddx = float3(dx,0,dhx);
    float3 ddy = float3(0,dy,dhy);
    float3 normal = cross(ddx,ddy);
    
    normal = normalize(normal);
    normal = normal * 0.5 + 0.5;
    return float4(normal,1);                

}

#endif