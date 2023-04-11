Shader "Unlit/BumpMapFromHeightMap_Rotate"
{
    Properties
    {
        _HeightMap ("Texture", 2D) = "white" {}
        //将颜色值从0~1 映射到高度值0~_BumpScale
        _BumpScale ("_BumpScale",float) = 100
        //将uv值0~1 映射到平面值 0~100
        _RealScopeSize ("_RealScopeSize",float) = 100
        
        _RotateAngle("_RotateAngle", float) = 0        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
        
        CGINCLUDE
        #include "BumpMap.hlsl"
        ENDCG

      
        //可以旋转的
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_rotate
            #pragma fragment frag_rotate
            #include "UnityCG.cginc"
           
            ENDCG
        }
        
    }
}
