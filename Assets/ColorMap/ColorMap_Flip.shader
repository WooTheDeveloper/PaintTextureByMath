Shader "Unlit/ColorMap_Flip"
{
    Properties
    {
        _ColorMap ("_ColorMap", 2D) = "white" {}
        _FlipX("_FlipX",float) = 0
        _FlipY("_FlipY",float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
        
        CGINCLUDE
        #include "ColorMap.hlsl" 
        ENDCG
       
        //基础的
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_flip
            #pragma fragment frag_flip
            #include "UnityCG.cginc"
           
            ENDCG
        }
        
    }
}
