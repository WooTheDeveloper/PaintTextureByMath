using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

public class CreateMain : MonoBehaviour
{
    public int size = 256;
    public TextureFormat format = TextureFormat.RGBA32;
    public string texName = "newTexName";
    public Material mat;
    public int pass = 0;
    
    public Texture2D CreateTex()
    {
        if (!mat)
        {
            Debug.Log("Shader cant be null!");
            return null;
        }
        
        var newTex = new Texture2D(size,size,format,true,true);
        var rt = new RenderTexture(size,size,0,RenderTextureFormat.ARGB32);
        Graphics.Blit(null,rt,new Material(mat),0);
        var orig = RenderTexture.active;
        RenderTexture.active = rt;
        newTex.ReadPixels(new Rect(0,0,size,size),0,0 );
        newTex.Apply();
        RenderTexture.active = orig;

        var bytes = newTex.EncodeToPNG();
        var path = $"Assets/{texName}.png";
        File.WriteAllBytes(path,bytes);
        AssetDatabase.Refresh();
        //var importer = AssetImporter.GetAtPath(path) as TextureImporter;
        newTex = AssetDatabase.LoadAssetAtPath<Texture2D>(path);
        Selection.activeObject = newTex;
        return newTex;
    }
    
}


[CustomEditor(typeof(CreateMain))]
public class CreateMainEditor : Editor
{
    public override void OnInspectorGUI()
    {
        base.OnInspectorGUI();
        if (GUILayout.Button("Create"))
        {
            var main = target as CreateMain;
            main.CreateTex();
        }
    }
}

