// ---- FNV Hash 9764bc66cb1470da

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

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

SamplerState GBufferTextureSamplerDepth_s : register(s3);
SamplerState PostFxSampler2_s : register(s4);
SamplerState HDRSampler_s : register(s5);
SamplerState BlurSampler_s : register(s7);
SamplerState MotionBlurSampler_s : register(s9);
SamplerState BloomSampler_s : register(s10);
SamplerState BloomSamplerG_s : register(s11);
SamplerState JitterSampler_s : register(s12);
SamplerState HeatHazeSampler_s : register(s13);
SamplerState PostFxSampler3_s : register(s14);
SamplerState SSLRSampler_s : register(s15);
Texture2D<float4> GBufferTextureSamplerDepth : register(t3);
Texture2D<float4> PostFxSampler2 : register(t4);
Texture2D<float4> HDRSampler : register(t5);
Texture2D<float4> BlurSampler : register(t7);
Texture2D<uint2> StencilCopyTexture : register(t8);
Texture2D<float4> MotionBlurSampler : register(t9);
Texture2D<float4> BloomSampler : register(t10);
Texture2D<float4> BloomSamplerG : register(t11);
Texture2D<float4> JitterSampler : register(t12);
Texture2D<float4> HeatHazeSampler : register(t13);
Texture2D<float4> PostFxSampler3 : register(t14);
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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = GBufferTextureSamplerDepth.Sample(GBufferTextureSamplerDepth_s, v1.xy).xyzw;
  r0.x = dofProj.w + -r0.x;
  r0.x = 1 + r0.x;
  r0.x = dofProj.z / r0.x;
  r1.xyzw = HDRSampler.Sample(HDRSampler_s, v1.xy).xyzw;
  r0.yzw = globalScalars3.www * r1.xyz;
  r1.x = cmp(0 < currentDOFTechnique);
  if (r1.x == 0) {
    r1.xyzw = TexelSize.xyxy * float4(-1,-0.5,0.5,-1) + v1.xyxy;
    r2.xyzw = PostFxSampler2.Sample(PostFxSampler2_s, r1.xy).xyzw;
    r3.xyzw = PostFxSampler2.Sample(PostFxSampler2_s, r1.zw).xyzw;
    r4.xyzw = TexelSize.xyxy * float4(-0.5,1,1,0.5) + v1.xyxy;
    r5.xyzw = PostFxSampler2.Sample(PostFxSampler2_s, r4.xy).xyzw;
    r6.xyzw = PostFxSampler2.Sample(PostFxSampler2_s, r4.zw).xyzw;
    r7.xyzw = PostFxSampler2.Sample(PostFxSampler2_s, v1.xy).xyzw;
    r2.xyz = r3.xyz + r2.xyz;
    r2.xyz = r2.xyz + r5.xyz;
    r2.xyz = r2.xyz + r6.xyz;
    r3.xyz = float3(0.5,0.5,0.5) * r7.xyz;
    r2.xyz = r7.xyz * float3(0.5,0.5,0.5) + r2.xyz;
    r5.xyzw = MotionBlurSampler.Sample(MotionBlurSampler_s, r1.xy).xyzw;
    r1.xyzw = MotionBlurSampler.Sample(MotionBlurSampler_s, r1.zw).xyzw;
    r6.xyzw = MotionBlurSampler.Sample(MotionBlurSampler_s, r4.xy).xyzw;
    r4.xyzw = MotionBlurSampler.Sample(MotionBlurSampler_s, r4.zw).xyzw;
    r7.xyzw = MotionBlurSampler.Sample(MotionBlurSampler_s, v1.xy).xyzw;
    r1.xyz = r5.xyz + r1.xyz;
    r1.xyz = r1.xyz + r6.xyz;
    r1.xyz = r1.xyz + r4.xyz;
    r1.xyz = r7.xyz * float3(0.5,0.5,0.5) + r1.xyz;
    r3.xyz = r7.xyz * float3(0.5,0.5,0.5) + r3.xyz;
    r2.xyz = float3(0.111111097,0.111111097,0.111111097) * r2.xyz;
    r1.xyz = r1.xyz * float3(0.111111097,0.111111097,0.111111097) + r2.xyz;
    r1.w = cmp(hiDofMiscParams.x != 0.000000);
    r2.xyz = r1.www ? r7.xyz : r3.xyz;
    r1.xyz = r1.www ? r7.xyz : r1.xyz;
    r3.xy = -hiDofParams.xz + r0.xx;
    r4.x = hiDofParams.w * r3.y;
    r1.w = saturate(-r3.x * hiDofParams.y + 1);
    r4.x = saturate(r4.x);
    r1.w = max(r4.x, r1.w);
    r3.xyz = saturate(r1.www * float3(-2.00400805,-2.00400805,-1000) + float3(1,2.00200391,1000));
    r1.w = 1 + -r3.x;
    r1.w = min(r3.y, r1.w);
    r2.w = r3.x + r1.w;
    r3.y = 1 + -r2.w;
    r3.y = min(r3.z, r3.y);
    r2.w = r3.y + r2.w;
    r2.w = 1 + -r2.w;
    r4.xyz = r7.xyz * r1.www;
    r3.xzw = r0.yzw * r3.xxx + r4.xyz;
    r2.xyz = r2.xyz * r3.yyy + r3.xzw;
    r0.yzw = r1.xyz * r2.www + r2.xyz;
  }
  if (BokehEnableVar != 0) {
    r1.xyzw = BloomSamplerG.Sample(BloomSamplerG_s, v1.xy).xyzw;
    r2.xyz = r1.xyz + -r0.yzw;
    r0.yzw = r1.www * r2.xyz + r0.yzw;
  } else {
    r1.xyzw = float4(0,0,0,0);
  }
  r2.xy = globalScreenSize.xy * v1.xy;
  r2.xy = (int2)r2.xy;
  r2.zw = float2(0,0);
  r2.xy = StencilCopyTexture.Load(r2.xyz).xy;
  r2.x = (uint)r2.y;
  r2.x = 0.00392156886 * r2.x;
  r2.x = cmp(PLAYER_MASK < r2.x);
  r2.x = r2.x ? 0 : 1;
  r2.yz = float2(58.1640015,47.1300011) * v1.xy;
  r3.xy = v1.xy * float2(2,-2) + float2(-1,1);
  r4.xy = v1.xy * float2(2,-2) + float2(-1,1);
  r4.zw = float2(1,1);
  r5.x = dot(r4.xyz, MBPerspectiveShearParams0.xyz);
  r5.y = dot(r4.xyz, MBPerspectiveShearParams1.xyz);
  r5.z = dot(r4.xyz, MBPerspectiveShearParams2.xyz);
  r4.xyz = r5.xyz * r0.xxx + gViewInverse._m30_m31_m32;
  r5.x = dot(r4.xyzw, MBPrevViewProjMatrixX.xyzw);
  r5.y = dot(r4.xyzw, MBPrevViewProjMatrixY.xyzw);
  r0.x = dot(r4.xyzw, MBPrevViewProjMatrixW.xyzw);
  r2.w = cmp(r0.x == 0.000000);
  r0.x = r2.w ? 9.99999975e-06 : r0.x;
  r3.zw = r5.xy / r0.xx;
  r3.xy = r3.xy + -r3.zw;
  r3.xy = float2(40,-22.5) * r3.xy;
  r0.x = dot(r3.xy, r3.xy);
  r2.w = cmp(1 < r0.x);
  r0.x = rsqrt(r0.x);
  r3.zw = r3.xy * r0.xx;
  r3.xy = r2.ww ? r3.zw : r3.xy;
  r3.xy = DirectionalMotionBlurParams.xx * r3.xy;
  r3.xy = float2(0.0125000002,0.0222222209) * r3.xy;
  r4.xyz = r2.xxx * r0.yzw;
  r3.zw = DirectionalMotionBlurIterParams.yy * r3.xy;
  r2.yz = r0.yz * float2(8,8) + r2.yz;
  r5.xyzw = JitterSampler.Sample(JitterSampler_s, r2.yz).xyzw;
  r0.x = -0.5 + r5.x;
  r2.yz = r3.zw * r0.xx;
  r2.yz = r2.yz * float2(0.5,0.5) + v1.xy;
  r0.x = (int)DirectionalMotionBlurIterParams.x;
  r5.zw = float2(0,0);
  r6.xyz = r4.xyz;
  r2.w = r2.x;
  r4.w = 1;
  while (true) {
    r6.w = cmp((int)r4.w >= (int)r0.x);
    if (r6.w != 0) break;
    r6.w = (int)r4.w;
    r7.xy = r3.zw * r6.ww + r2.yz;
    r7.xy = globalScreenSize.xy * r7.xy;
    r7.xy = round(r7.xy);
    r7.xy = float2(0.5,0.5) + r7.xy;
    r7.zw = r7.xy / globalScreenSize.xy;
    r5.xy = (int2)r7.xy;
    r8.xy = StencilCopyTexture.Load(r5.xyz).xy;
    r5.x = (uint)r8.y;
    r5.x = 0.00392156886 * r5.x;
    r5.x = cmp(PLAYER_MASK < r5.x);
    r5.x = r5.x ? 0 : 1;
    r7.xyzw = MotionBlurSampler.SampleLevel(MotionBlurSampler_s, r7.zw, 0).xyzw;
    r6.xyz = r7.xyz * r5.xxx + r6.xyz;
    r2.w = r5.x + r2.w;
    r4.w = (int)r4.w + 1;
  }
  r0.x = max(0.100000001, r2.w);
  r2.yzw = r6.xyz / r0.xxx;
  r0.x = dot(r3.xy, r3.xy);
  r0.x = 100000 * r0.x;
  r0.x = min(1, r0.x);
  r0.x = r2.x * r0.x;
  r2.xyz = r2.yzw + -r0.yzw;
  r0.xyz = r0.xxx * r2.xyz + r0.yzw;
  r2.xyzw = PostFxSampler3.Sample(PostFxSampler3_s, v1.xy).xyzw;
  r1.xyz = -r2.xyz + r1.xyz;
  r1.xyz = r1.www * r1.xyz + r2.xyz;
  r1.xyz = BokehEnableVar ? r1.xyz : r2.xyz;
  r1.xyz = r1.xyz + -r0.xyz;
  r0.xyz = ScreenBlurFade * r1.xyz + r0.xyz;
  r1.xyzw = BloomSampler.Sample(BloomSampler_s, v1.xy).xyzw;
  r1.xyz = v1.www * r1.xyz;
  r0.w = cmp(0 < sslrParams.z);
  if (r0.w != 0) {
    r2.xyzw = SSLRSampler.Sample(SSLRSampler_s, v1.xy).xyzw;
    r0.w = r2.x * r2.x;
    r0.w = r0.w * r0.w;
    r0.w = r0.w * r0.w;
    r0.xyz = lightrayParams.xyz * r0.www + r0.xyz;
  }
  r2.xyzw = HeatHazeSampler.Sample(HeatHazeSampler_s, v1.xy).xyzw;
  r0.w = -LensArtefactsParams0.x + v1.z;
  r0.w = saturate(LensArtefactsParams0.y * r0.w);
  r1.w = LensArtefactsParams0.w + -LensArtefactsParams0.z;
  r0.w = r0.w * r1.w + LensArtefactsParams0.z;
  r0.w = -1 + r0.w;
  r0.w = LensArtefactsParams1.x * r0.w + 1;
  r0.w = LensArtefactsParams2.w * r0.w;
  r0.xyz = r2.xyz * r0.www + r0.xyz;
  r1.xyz = BloomParams.yyy * r1.xyz;
  r0.xyz = r1.xyz * float3(0.25,0.25,0.25) + r0.xyz;
  o0.xyz = r0.xyz;
  o0.w = 1;
  return;
}