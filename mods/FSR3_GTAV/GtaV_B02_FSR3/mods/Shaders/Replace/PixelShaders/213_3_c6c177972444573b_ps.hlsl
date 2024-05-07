// ---- FNV Hash c6c177972444573b

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer misc_globals : register(b2)
{
  float4 globalFade : packoffset(c0);
  float globalHeightScale : packoffset(c1);
  float globalShaderQuality : packoffset(c1.y);
  float globalReuseMe00001 : packoffset(c1.z);
  float globalReuseMe00002 : packoffset(c1.w);
  float4 POMFlags : packoffset(c2);
  float4 g_Rage_Tessellation_CameraPosition : packoffset(c3);
  float4 g_Rage_Tessellation_CameraZAxis : packoffset(c4);
  float4 g_Rage_Tessellation_ScreenSpaceErrorParams : packoffset(c5);
  float4 g_Rage_Tessellation_LinearScale : packoffset(c6);
  float4 g_Rage_Tessellation_Frustum[4] : packoffset(c7);
  float4 g_Rage_Tessellation_Epsilons : packoffset(c11);
  float4 globalScalars : packoffset(c12);
  float4 globalScalars2 : packoffset(c13);
  float4 globalScalars3 : packoffset(c14);
  float4 globalScreenSize : packoffset(c15);
  uint4 gTargetAAParams : packoffset(c16);
  float4 colorize : packoffset(c17);
  float4 gGlobalParticleShadowBias : packoffset(c18);
  float gGlobalParticleDofAlphaScale : packoffset(c19);
  float gGlobalFogIntensity : packoffset(c19.y);
  float4 gPlayerLFootPos : packoffset(c20);
  float4 gPlayerRFootPos : packoffset(c21);
}

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

SamplerState GBufferTextureSamplerDepth_s : register(s3);
SamplerState HDRSampler_s : register(s5);
SamplerState BackBufferSampler_s : register(s6);
SamplerState BlurSampler_s : register(s7);
SamplerState MotionBlurSampler_s : register(s9);
SamplerState BloomSampler_s : register(s10);
SamplerState HeatHazeSampler_s : register(s13);
SamplerState SSLRSampler_s : register(s15);
Texture2D<float4> GBufferTextureSamplerDepth : register(t3);
Texture2D<float4> HDRSampler : register(t5);
Texture2D<float4> BackBufferSampler : register(t6);
Texture2D<float4> BlurSampler : register(t7);
Texture2D<float4> MotionBlurSampler : register(t9);
Texture2D<float4> BloomSampler : register(t10);
Texture2D<float4> HeatHazeSampler : register(t13);
Texture2D<float4> SSLRSampler : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float v2 : TEXCOORD1,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = GBufferTextureSamplerDepth.Sample(GBufferTextureSamplerDepth_s, v1.xy).xyzw;
  r0.x = 1 + -r0.x;
  r0.y = dofProj.w + r0.x;
  r0.y = dofProj.z / r0.y;
  r0.x = cmp(r0.x != 0.000000);
  r0.x = r0.x ? 1.000000 : 0;
  r0.z = -dofDist.x + r0.y;
  r0.z = saturate(dofDist.y * r0.z);
  r0.z = dofDist.z * r0.z;
  r0.x = r0.z * r0.x;
  r0.z = cmp(HeatHazeParams.y < r0.y);
  r0.y = cmp(r0.y < HeatHazeParams.y);
  r0.y = r0.y ? r0.z : 0;
  r0.y = r0.y ? 1.000000 : 0;
  r1.xyzw = BackBufferSampler.Sample(BackBufferSampler_s, v1.xy).xyzw;
  r0.z = HeatHazeOffsetParams.z * r1.x;
  r0.y = r0.z * r0.y;
  r0.z = HeatHazeParams.w + -HeatHazeParams.z;
  r0.y = r0.y * r0.z + HeatHazeParams.z;
  r0.zw = v1.xy * HeatHazeTex1Params.xy + HeatHazeTex1Params.zw;
  r1.xy = v1.xy * HeatHazeTex2Params.xy + HeatHazeTex2Params.zw;
  r2.xyzw = HeatHazeSampler.Sample(HeatHazeSampler_s, r0.zw).xyzw;
  r1.xyzw = HeatHazeSampler.Sample(HeatHazeSampler_s, r1.xy).xyzw;
  r0.zw = r2.xy + r1.xy;
  r0.zw = float2(-1,-1) + r0.zw;
  r0.zw = HeatHazeOffsetParams.xy * r0.zw;
  r0.zw = r0.zw * r0.yy + v1.xy;
  r1.xyzw = HDRSampler.Sample(HDRSampler_s, r0.zw).xyzw;
  r2.xyz = globalScalars3.www * r1.xyz;
  r0.x = saturate(max(r0.x, r0.y));
  r3.xyzw = MotionBlurSampler.Sample(MotionBlurSampler_s, r0.zw).xyzw;
  r1.xyz = -r1.xyz * globalScalars3.www + r3.xyz;
  r1.xyz = r0.xxx * r1.xyz + r2.xyz;
  r2.xyzw = BloomSampler.Sample(BloomSampler_s, r0.zw).xyzw;
  r2.xyz = v1.www * r2.xyz;
  r0.x = cmp(0 < sslrParams.z);
  if (r0.x != 0) {
    r0.xyzw = SSLRSampler.Sample(SSLRSampler_s, r0.zw).xyzw;
    r0.x = r0.x * r0.x;
    r0.x = r0.x * r0.x;
    r0.x = r0.x * r0.x;
    r1.xyz = lightrayParams.xyz * r0.xxx + r1.xyz;
  }
  r0.xyz = BloomParams.yyy * r2.xyz;
  r0.xyz = r0.xyz * float3(0.25,0.25,0.25) + r1.xyz;
  r1.xy = float2(-0.5,-0.5) + v1.xy;
  r0.w = dot(r1.xy, r1.xy);
  r0.w = 1 + -r0.w;
  r0.w = log2(r0.w);
  r0.w = VignettingParams.y * r0.w;
  r0.w = exp2(r0.w);
  r0.w = saturate(VignettingParams.x + r0.w);
  r0.w = saturate(VignettingParams.z * r0.w);
  r1.xyz = float3(1,1,1) + -VignettingColor.xyz;
  r1.xyz = r0.www * r1.xyz + VignettingColor.xyz;
  r0.xyz = r1.xyz * r0.xyz;
  r0.xyz = min(float3(65504,65504,65504), r0.xyz);
  r0.w = saturate(v2.x * TonemapParams.x + TonemapParams.y);
  r1.xyzw = DarkTonemapParams0.xyzw + -BrightTonemapParams0.xyzw;
  r1.xyzw = r0.wwww * r1.xyzw + BrightTonemapParams0.xyzw;
  r2.xyz = DarkTonemapParams1.zxy + -BrightTonemapParams1.zxy;
  r2.xyz = r0.www * r2.xyz + BrightTonemapParams1.zxy;
  r3.xy = r2.yz * r1.ww;
  r0.w = r1.z * r1.y;
  r1.z = r1.x * r2.x + r0.w;
  r1.z = r2.x * r1.z + r3.x;
  r1.w = r1.x * r2.x + r1.y;
  r1.w = r2.x * r1.w + r3.y;
  r1.z = r1.z / r1.w;
  r1.w = r2.y / r2.z;
  r1.z = r1.z + -r1.w;
  r1.z = 1 / r1.z;
  r0.xyz = v1.zzz * r0.xyz;
  r0.xyz = max(float3(0,0,0), r0.xyz);
  r2.xyz = r1.xxx * r0.xyz + r0.www;
  r2.xyz = r0.xyz * r2.xyz + r3.xxx;
  r3.xzw = r1.xxx * r0.xyz + r1.yyy;
  r0.xyz = r0.xyz * r3.xzw + r3.yyy;
  r0.xyz = r2.xyz / r0.xyz;
  r0.xyz = r0.xyz + -r1.www;
  r0.xyz = saturate(r0.xyz * r1.zzz);
  r0.w = dot(r0.xyz, float3(0.212500006,0.715399981,0.0720999986));
  r0.xyz = r0.xyz + -r0.www;
  r0.xyz = Desaturate * r0.xyz + r0.www;
  r1.x = saturate(r0.w / ColorShiftLowLum.w);
  r1.yzw = -ColorShiftLowLum.xyz + ColorCorrectHighLum.xyz;
  r1.xyz = r1.xxx * r1.yzw + ColorShiftLowLum.xyz;
  r2.xyz = r1.xyz * r0.xyz;
  r1.w = 1 + -ColorCorrectHighLum.w;
  r0.w = -r1.w + r0.w;
  r1.w = 1 + -r1.w;
  r1.w = max(0.00999999978, r1.w);
  r0.w = saturate(r0.w / r1.w);
  r0.xyz = -r0.xyz * r1.xyz + r0.xyz;
  r0.xyz = saturate(r0.www * r0.xyz + r2.xyz);
  r0.xyz = log2(r0.xyz);
  r0.xyz = Gamma * r0.xyz;
  r0.xyz = exp2(r0.xyz);
  r1.xy = NoiseParams.ww * v1.xy;
  r1.xy = r1.xy * float2(1.60000002,0.899999976) + NoiseParams.xy;
  r1.xy = frac(r1.xy);
  r1.xyzw = BlurSampler.Sample(BlurSampler_s, r1.xy).xyzw;
  r0.w = -0.5 + r1.w;
  r0.xyz = saturate(r0.www * NoiseParams.zzz + r0.xyz);
  o0.w = dot(r0.xyz, float3(0.298999995,0.587000012,0.114));
  o0.xyz = r0.xyz;
  return;
}