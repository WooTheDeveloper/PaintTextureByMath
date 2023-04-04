Shader "Unlit/FlowMapGather"
{
    Properties
    {
        
        _DistanceFadePow("_DistanceFadePow",float) = 1
        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
        
       

        //0
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag_gather

            #include "UnityCG.cginc"
            #include "FlowMap.hlsl"
          
            ENDCG
        }
        
        
    }
}
