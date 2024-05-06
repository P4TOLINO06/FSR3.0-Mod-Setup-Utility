// ---- FNV Hash 1836f011ee30b34a

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

cbuffer _Globals : register(b0)
{
  float EAdaptationMinV1 : packoffset(c0) = {0.00999999978};
  float EAdaptationMaxV1 : packoffset(c0.y) = {0.0700000003};
  float EContrastV1 : packoffset(c0.z) = {0.949999988};
  float EColorSaturationV1 : packoffset(c0.w) = {1};
  float EToneMappingCurveV1 : packoffset(c1) = {6};
  float EAdaptationMinV2 : packoffset(c1.y) = {0.0500000007};
  float EAdaptationMaxV2 : packoffset(c1.z) = {0.0500000007};
  float EToneMappingCurveV2 : packoffset(c1.w) = {8};
  float EIntensityContrastV2 : packoffset(c2) = {1};
  float EColorSaturationV2 : packoffset(c2.y) = {1};
  float EToneMappingOversaturationV2 : packoffset(c2.z) = {180};
  float EAdaptationMinV3 : packoffset(c2.w) = {0.0500000007};
  float EAdaptationMaxV3 : packoffset(c3) = {0.125};
  float EToneMappingCurveV3 : packoffset(c3.y) = {4};
  float EToneMappingOversaturationV3 : packoffset(c3.z) = {60};
  float EAdaptationMinV4 : packoffset(c3.w) = {0.200000003};
  float EAdaptationMaxV4 : packoffset(c4) = {0.125};
  float EBrightnessCurveV4 : packoffset(c4.y) = {0.699999988};
  float EBrightnessMultiplierV4 : packoffset(c4.z) = {0.449999988};
  float EBrightnessToneMappingCurveV4 : packoffset(c4.w) = {0.5};
  float4 Timer : packoffset(c5);
  float4 ScreenSize : packoffset(c6);
  float AdaptiveQuality : packoffset(c7);
  float4 Weather : packoffset(c8);
  float4 TimeOfDay1 : packoffset(c9);
  float4 TimeOfDay2 : packoffset(c10);
  float ENightDayFactor : packoffset(c11);
  float EInteriorFactor : packoffset(c11.y);
  float4 tempF1 : packoffset(c12);
  float4 tempF2 : packoffset(c13);
  float4 tempF3 : packoffset(c14);
  float4 tempInfo1 : packoffset(c15);
  float4 tempInfo2 : packoffset(c16);
  float4 ENBParams01 : packoffset(c17);
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

SamplerState Sampler0_s : register(s0);
SamplerState Sampler1_s : register(s1);
Texture2D<float4> TextureColor : register(t0);
Texture2D<float4> TextureBloom : register(t1);
Texture2D<float4> TextureLens : register(t2);
Texture2D<float4> TextureAdaptation : register(t3);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(-0.5,-0.5) + v1.xy;
  r0.x = dot(r0.xy, r0.xy);
  r0.x = 1 + -r0.x;
  r0.x = log2(r0.x);
  r0.x = VignettingParams.y * r0.x;
  r0.x = exp2(r0.x);
  r0.x = saturate(VignettingParams.x + r0.x);
  r0.x = saturate(VignettingParams.z * r0.x);
  r0.yzw = -VignettingColor.xyz + float3(1,1,1);
  r0.xyz = r0.xxx * r0.yzw + VignettingColor.xyz;
  r1.xyz = TextureColor.Sample(Sampler0_s, v1.xy).xyz;
  r2.xyz = TextureLens.Sample(Sampler1_s, v1.xy).xyz;
  r1.xyz = r2.xyz * ENBParams01.yyy + r1.xyz;
  r2.xyz = TextureBloom.Sample(Sampler1_s, v1.xy).xyz;
  r2.xyz = r2.xyz + -r1.xyz;
  r2.xyz = max(float3(0,0,0), r2.xyz);
  r1.xyz = r2.xyz * ENBParams01.xxx + r1.xyz;
  r0.xyz = r1.xyz * r0.xyz;
  r0.xyz = min(float3(65504,65504,65504), r0.xyz);
  r1.xy = TextureAdaptation.Sample(Sampler0_s, v1.xy).xy;
  r0.xyz = r1.xxx * r0.xyz;
  r0.w = saturate(r1.y * TonemapParams.x + TonemapParams.y);
  r0.xyz = max(float3(0,0,0), r0.xyz);
  r1.xyzw = DarkTonemapParams0.xyzw + -BrightTonemapParams0.xyzw;
  r1.xyzw = r0.wwww * r1.xyzw + BrightTonemapParams0.xyzw;
  r1.z = r1.z * r1.y;
  r2.xyz = r1.xxx * r0.xyz + r1.zzz;
  r3.xyz = DarkTonemapParams1.xyz + -BrightTonemapParams1.xyz;
  r3.xyz = r0.www * r3.xyz + BrightTonemapParams1.xyz;
  r4.xy = r3.xy * r1.ww;
  r2.xyz = r0.xyz * r2.xyz + r4.xxx;
  r5.xyz = r1.xxx * r0.xyz + r1.yyy;
  r0.xyz = r0.xyz * r5.xyz + r4.yyy;
  r0.xyz = r2.xyz / r0.xyz;
  r0.w = r3.x / r3.y;
  r0.xyz = r0.xyz + -r0.www;
  r1.z = r3.z * r1.x + r1.z;
  r1.x = r3.z * r1.x + r1.y;
  r1.x = r3.z * r1.x + r4.y;
  r1.y = r3.z * r1.z + r4.x;
  r1.x = r1.y / r1.x;
  r0.w = r1.x + -r0.w;
  r0.w = 1 / r0.w;
  r0.xyz = saturate(r0.xyz * r0.www);
  r0.w = dot(r0.xyz, float3(0.212500006,0.715399981,0.0720999986));
  r0.xyz = r0.xyz + -r0.www;
  r0.xyz = Desaturate * r0.xyz + r0.www;
  r1.x = saturate(r0.w / ColorShiftLowLum.w);
  r1.yzw = -ColorShiftLowLum.xyz + ColorCorrectHighLum.xyz;
  r1.xyz = r1.xxx * r1.yzw + ColorShiftLowLum.xyz;
  r2.xyz = r1.xyz * r0.xyz;
  r0.xyz = -r0.xyz * r1.xyz + r0.xyz;
  r1.x = -ColorCorrectHighLum.w + 1;
  r0.w = -r1.x + r0.w;
  r1.x = 1 + -r1.x;
  r1.x = max(0.00999999978, r1.x);
  r0.w = saturate(r0.w / r1.x);
  r0.xyz = saturate(r0.www * r0.xyz + r2.xyz);
  r0.xyz = log2(r0.xyz);
  r0.xyz = Gamma * r0.xyz;
  o0.xyz = exp2(r0.xyz);
  o0.w = 1;
  return;
}