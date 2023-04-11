Shader "Unlit/BumpMapFromHeightMap"
{
    Properties
    {
        _HeightMap ("Texture", 2D) = "white" {}
        //将颜色值从0~1 映射到高度值0~_BumpScale
        _BumpScale ("_BumpScale",float) = 100
        //将uv值0~1 映射到平面值 0~100
        _RealScopeSize ("_RealScopeSize",float) = 100
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
        
        CGINCLUDE
        #include "BumpMap.hlsl"
        ENDCG
       
        //基础的
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
           
            ENDCG
        }
        
    }
}
