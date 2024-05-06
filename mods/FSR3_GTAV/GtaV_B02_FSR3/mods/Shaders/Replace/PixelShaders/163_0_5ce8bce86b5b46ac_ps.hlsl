// ---- FNV Hash 5ce8bce86b5b46ac

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

struct AdaptiveDOFStruct
{
    float distanceToSubject;       // Offset:    0
    float maxBlurDiskRadiusNear;   // Offset:    4
    float maxBlurDiskRadiusFar;    // Offset:    8
    float springResult;            // Offset:   12
    float springVelocity;          // Offset:   16
};

cbuffer postfx_cbuffer : register(b5)
{
  float4 dofProj : packoffset(c0);
  float4 dofShear : packoffset(c1);
  float4 dofDist : packoffset(c2);
  float4 hiDofParams : packoffset(c3);
  float4 hiDofMiscParams : packoffset(c4);
  float4 PostFXAdaptiveDofEnvBlurParams : packoffset(c5);
  float4 PostFXAdaptiveDofCustomPlanesParams : packoffset(c6);
  float4 BloomParams : packoffset(c7);
  float4 Filmic0 : packoffset(c8);
  float4 Filmic1 : packoffset(c9);
  float4 BrightTonemapParams0 : packoffset(c10);
  float4 BrightTonemapParams1 : packoffset(c11);
  float4 DarkTonemapParams0 : packoffset(c12);
  float4 DarkTonemapParams1 : packoffset(c13);
  float2 TonemapParams : packoffset(c14);
  float4 NoiseParams : packoffset(c15);
  float4 DirectionalMotionBlurParams : packoffset(c16);
  float4 DirectionalMotionBlurIterParams : packoffset(c17);
  float4 MBPrevViewProjMatrixX : packoffset(c18);
  float4 MBPrevViewProjMatrixY : packoffset(c19);
  float4 MBPrevViewProjMatrixW : packoffset(c20);
  float3 MBPerspectiveShearParams0 : packoffset(c21);
  float3 MBPerspectiveShearParams1 : packoffset(c22);
  float3 MBPerspectiveShearParams2 : packoffset(c23);
  float lowLum : packoffset(c23.w);
  float highLum : packoffset(c24);
  float topLum : packoffset(c24.y);
  float scalerLum : packoffset(c24.z);
  float offsetLum : packoffset(c24.w);
  float offsetLowLum : packoffset(c25);
  float offsetHighLum : packoffset(c25.y);
  float noiseLum : packoffset(c25.z);
  float noiseLowLum : packoffset(c25.w);
  float noiseHighLum : packoffset(c26);
  float bloomLum : packoffset(c26.y);
  float4 colorLum : packoffset(c27);
  float4 colorLowLum : packoffset(c28);
  float4 colorHighLum : packoffset(c29);
  float4 HeatHazeParams : packoffset(c30);
  float4 HeatHazeTex1Params : packoffset(c31);
  float4 HeatHazeTex2Params : packoffset(c32);
  float4 HeatHazeOffsetParams : packoffset(c33);
  float4 LensArtefactsParams0 : packoffset(c34);
  float4 LensArtefactsParams1 : packoffset(c35);
  float4 LensArtefactsParams2 : packoffset(c36);
  float4 LensArtefactsParams3 : packoffset(c37);
  float4 LensArtefactsParams4 : packoffset(c38);
  float4 LensArtefactsParams5 : packoffset(c39);
  float4 LightStreaksColorShift0 : packoffset(c40);
  float4 LightStreaksBlurColWeights : packoffset(c41);
  float4 LightStreaksBlurDir : packoffset(c42);
  float4 globalFreeAimDir : packoffset(c43);
  float4 globalFogRayParam : packoffset(c44);
  float4 globalFogRayFadeParam : packoffset(c45);
  float4 lightrayParams : packoffset(c46);
  float4 lightrayParams2 : packoffset(c47);
  float4 seeThroughParams : packoffset(c48);
  float4 seeThroughColorNear : packoffset(c49);
  float4 seeThroughColorFar : packoffset(c50);
  float4 seeThroughColorVisibleBase : packoffset(c51);
  float4 seeThroughColorVisibleWarm : packoffset(c52);
  float4 seeThroughColorVisibleHot : packoffset(c53);
  float4 debugParams0 : packoffset(c54);
  float4 debugParams1 : packoffset(c55);
  float PLAYER_MASK : packoffset(c56);
  float4 VignettingParams : packoffset(c57);
  float4 VignettingColor : packoffset(c58);
  float4 GradientFilterColTop : packoffset(c59);
  float4 GradientFilterColBottom : packoffset(c60);
  float4 GradientFilterColMiddle : packoffset(c61);
  float4 DamageOverlayMisc : packoffset(c62);
  float4 ScanlineFilterParams : packoffset(c63);
  float ScreenBlurFade : packoffset(c64);
  float4 ColorCorrectHighLum : packoffset(c65);
  float4 ColorShiftLowLum : packoffset(c66);
  float Desaturate : packoffset(c67);
  float Gamma : packoffset(c67.y);
  float4 LensDistortionParams : packoffset(c68);
  float4 DistortionParams : packoffset(c69);
  float4 BlurVignettingParams : packoffset(c70);
  float4 BloomTexelSize : packoffset(c71);
  float4 TexelSize : packoffset(c72);
  float4 GBufferTexture0Param : packoffset(c73);
  float2 rcpFrame : packoffset(c74);
  float4 sslrParams : packoffset(c75);
  float3 sslrCenter : packoffset(c76);
  float4 ExposureParams0 : packoffset(c77);
  float4 ExposureParams1 : packoffset(c78);
  float4 ExposureParams2 : packoffset(c79);
  float4 ExposureParams3 : packoffset(c80);
  float4 LuminanceDownsampleOOSrcDstSize : packoffset(c81);
  float4 QuadPosition : packoffset(c82);
  float4 QuadTexCoords : packoffset(c83);
  float4 QuadScale : packoffset(c84);
  float4 BokehBrightnessParams : packoffset(c85);
  float4 BokehParams1 : packoffset(c86);
  float4 BokehParams2 : packoffset(c87);
  float2 DOFTargetSize : packoffset(c88);
  float2 RenderTargetSize : packoffset(c88.z);
  float BokehGlobalAlpha : packoffset(c89);
  float BokehAlphaCutoff : packoffset(c89.y);
  bool BokehEnableVar : packoffset(c89.z);
  float BokehSortLevel : packoffset(c89.w);
  float BokehSortLevelMask : packoffset(c90);
  float BokehSortTransposeMatWidth : packoffset(c90.y);
  float BokehSortTransposeMatHeight : packoffset(c90.z);
  float currentDOFTechnique : packoffset(c90.w);
  float4 fpvMotionBlurWeights : packoffset(c91);
  float3 fpvMotionBlurVelocity : packoffset(c92);
  float fpvMotionBlurSize : packoffset(c92.w);
}

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

SamplerState PostFxSampler2_s : register(s4);
SamplerState PtfxDepthMapSampler_s : register(s11);
SamplerState PtfxAlphaMapSampler_s : register(s12);
StructuredBuffer<AdaptiveDOFStruct> AdaptiveDOFParamsBuffer : register(t1);
Texture2D<float4> PostFxSampler2 : register(t4);
Texture2D<float4> PtfxDepthMapSampler : register(t11);
Texture2D<float4> PtfxAlphaMapSampler : register(t12);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 pos : POSITION0,
  out float2 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = PostFxSampler2.Sample(PostFxSampler2_s, v1.xy).x;
  r0.x = dofProj.w + -r0.x;
  r0.x = 1 + r0.x;
  r0.x = dofProj.z / r0.x;
  r0.y = PtfxDepthMapSampler.Sample(PtfxDepthMapSampler_s, v1.xy).x;
  r0.z = PtfxAlphaMapSampler.Sample(PtfxAlphaMapSampler_s, v1.xy).x;
  r0.z = saturate(r0.z);
  r0.y = r0.y + -r0.x;
  r0.x = r0.z * r0.y + r0.x;
  r0.z = cmp(r0.x < 9.99999997e-07);
  if (r0.z != 0) {
    r0.y = 1;
  } else {
    r1.x = AdaptiveDOFParamsBuffer[0].distanceToSubject;
    r1.y = AdaptiveDOFParamsBuffer[0].maxBlurDiskRadiusNear;
    r1.z = AdaptiveDOFParamsBuffer[0].maxBlurDiskRadiusFar;
    r0.z = r1.x / r0.x;
    r0.w = cmp(1 < r0.z);
    r1.x = -1 + r0.z;
    r1.x = r1.y * r1.x;
    r1.x = log2(r1.x);
    r1.x = PostFXAdaptiveDofCustomPlanesParams.z * r1.x;
    r2.x = exp2(r1.x);
    r0.z = 1 + -r0.z;
    r2.z = r1.z * r0.z;
    r2.yw = float2(-1,1);
    r1.xy = r0.ww ? r2.xy : r2.zw;
    r1.zw = cmp(r0.xx >= PostFXAdaptiveDofEnvBlurParams.yx);
    r0.z = PostFXAdaptiveDofEnvBlurParams.y + -PostFXAdaptiveDofEnvBlurParams.x;
    r2.x = cmp(r0.z >= 9.99999997e-07);
    r2.y = -PostFXAdaptiveDofEnvBlurParams.x + r0.x;
    r2.y = PostFXAdaptiveDofEnvBlurParams.z * r2.y;
    r0.z = r2.y / r0.z;
    r0.z = r2.x ? r0.z : 0;
    r0.z = r1.w ? r0.z : 0;
    r0.z = r1.z ? PostFXAdaptiveDofEnvBlurParams.z : r0.z;
    r0.z = max(r1.x, r0.z);
    r1.xz = -hiDofParams.xz + r0.xx;
    r1.xz = saturate(hiDofParams.yw * r1.xz);
    r1.x = 1 + -r1.x;
    r1.x = r1.x + r1.z;
    r1.x = min(1, r1.x);
    r1.x = PostFXAdaptiveDofCustomPlanesParams.y * r1.x + -r0.z;
    r0.z = PostFXAdaptiveDofCustomPlanesParams.x * r1.x + r0.z;
    r0.w = r0.w ? 2.000000 : 0;
    r0.w = PostFXAdaptiveDofCustomPlanesParams.x * r0.w + r1.y;
    r0.z = 0.0666666701 * r0.z;
    r0.z = min(1, r0.z);
    r1.x = 1 + -r0.z;
    r0.z = PostFXAdaptiveDofEnvBlurParams.w * r1.x + r0.z;
    r0.w = cmp(r0.w < 0);
    r1.x = cmp(0 < PostFXAdaptiveDofEnvBlurParams.w);
    r1.x = (int)r1.x | (int)r1.w;
    r1.x = ~(int)r1.x;
    r0.w = r0.w ? r1.x : 0;
    r0.y = r0.w ? -r0.z : r0.z;
  }
  o0.xy = r0.xy;
  return;
}