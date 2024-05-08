// ---- FNV Hash c4a10d25e6cab86e

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer csmshader : register(b6)
{
  float4 gCSMShaderVars_shared[12] : packoffset(c0);
  float4 gCSMDepthBias : packoffset(c12);
  float4 gCSMDepthSlopeBias : packoffset(c13);
  float4 gCSMResolution : packoffset(c14);
  float4 gCSMShadowParams : packoffset(c15);
  row_major float4x4 gLocalLightShadowData[8] : packoffset(c16);
  float4 gShadowTexParam : packoffset(c48);
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

SamplerState ResolvedDepthSampler_s : register(s4);
SamplerComparisonState gCSMShadowTextureSamp_s : register(s15);
Texture2D<float> ResolvedDepthTexture : register(t4);
Texture2D<float4> gCSMShadowTexture : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
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

  r0.xyzw = ResolvedDepthTexture.Gather(ResolvedDepthSampler_s, v1.xy).xyzw;
  r0.xyzw = float4(1,1,1,1) + -r0.xyzw;
  r0.xy = max(r0.xy, r0.zw);
  r0.x = max(r0.x, r0.y);
  r0.x = dofProj.w + r0.x;
  r0.x = dofProj.z / r0.x;
  r0.yzw = v2.xyz * r0.xxx;
  r1.x = dot(r0.yzw, r0.yzw);
  r1.x = sqrt(r1.x);
  r1.y = dot(v1.xy, float2(25.9796009,156.466003));
  r1.y = sin(r1.y);
  r1.y = 43758.5469 * r1.y;
  r1.y = frac(r1.y);
  r1.y = r1.y * 2 + -1;
  r1.y = 0.5 * r1.y;
  r2.x = globalFogRayFadeParam.y * r1.x;
  r1.x = saturate(r1.x * globalFogRayFadeParam.z + globalFogRayFadeParam.w);
  r1.x = r1.x * r1.y;
  r1.yz = float2(0.333333343,0.333333343) * v0.xy;
  r2.yz = cmp(r1.yz >= -r1.yz);
  r1.yz = frac(abs(r1.yz));
  r1.yz = r2.yz ? r1.yz : -r1.yz;
  r1.yz = float2(3,9) * r1.yz;
  r1.y = r1.y + r1.z;
  r0.yzw = float3(0.111111112,0.111111112,0.111111112) * r0.yzw;
  r1.yzw = r0.yzw * r1.yyy;
  r1.yzw = r1.yzw * float3(0.111111112,0.111111112,0.111111112) + gViewInverse._m30_m31_m32;
  r1.xyz = r1.xxx * r0.yzw + r1.yzw;
  r1.w = -gCSMResolution.z * 1.5 + 1;
  r1.w = 0.5 * r1.w;
  r1.xyz = -gViewInverse._m30_m31_m32 + r1.xyz;
  r2.yzw = gCSMShaderVars_shared[1].xyz * r1.yyy;
  r2.yzw = r1.xxx * gCSMShaderVars_shared[0].xyz + r2.yzw;
  r1.xyz = r1.zzz * gCSMShaderVars_shared[2].xyz + r2.yzw;
  r2.yzw = gCSMShaderVars_shared[1].xyz * r0.zzz;
  r2.yzw = r0.yyy * gCSMShaderVars_shared[0].xyz + r2.yzw;
  r0.yzw = r0.www * gCSMShaderVars_shared[2].xyz + r2.yzw;
  r3.xyz = r1.xyz * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
  r4.xyz = r1.xyz * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
  r5.xyz = r1.xyz * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
  r6.xyz = r1.xyz * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
  r1.x = max(abs(r3.x), abs(r3.y));
  r1.y = max(abs(r4.x), abs(r4.y));
  r1.z = max(abs(r5.x), abs(r5.y));
  r1.xyz = cmp(r1.xyz < r1.www);
  r2.y = max(abs(r6.x), abs(r6.y));
  r2.y = cmp(r2.y < r1.w);
  r6.w = 0.875;
  r7.xyzw = r2.yyyy ? r6.xyzw : float4(0,0,0,5);
  r5.w = 0.625;
  r7.xyzw = r1.zzzz ? r5.xyzw : r7.xyzw;
  r4.w = 0.375;
  r7.xyzw = r1.yyyy ? r4.xyzw : r7.xyzw;
  r3.w = 0.125;
  r7.xyzw = r1.xxxx ? r3.xyzw : r7.xyzw;
  r1.x = cmp(r7.w != 5.000000);
  if (r1.x != 0) {
    r1.x = 0.5 + r7.x;
    r1.y = r7.y * 0.25 + r7.w;
    r1.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r1.xy, r7.z).x;
  } else {
    r1.x = 1;
  }
  r3.xyz = r0.yzw * gCSMShaderVars_shared[4].xyz + r3.xyz;
  r4.xyz = r0.yzw * gCSMShaderVars_shared[5].xyz + r4.xyz;
  r5.xyz = r0.yzw * gCSMShaderVars_shared[6].xyz + r5.xyz;
  r6.xyz = r0.yzw * gCSMShaderVars_shared[7].xyz + r6.xyz;
  r1.y = max(abs(r3.x), abs(r3.y));
  r1.z = max(abs(r4.x), abs(r4.y));
  r1.yz = cmp(r1.yz < r1.ww);
  r2.y = max(abs(r5.x), abs(r5.y));
  r2.z = max(abs(r6.x), abs(r6.y));
  r2.yz = cmp(r2.yz < r1.ww);
  r6.w = 0.875;
  r7.xyzw = r2.zzzz ? r6.xyzw : float4(0,0,0,5);
  r5.w = 0.625;
  r7.xyzw = r2.yyyy ? r5.xyzw : r7.xyzw;
  r4.w = 0.375;
  r7.xyzw = r1.zzzz ? r4.xyzw : r7.xyzw;
  r3.w = 0.125;
  r7.xyzw = r1.yyyy ? r3.xyzw : r7.xyzw;
  r1.y = cmp(r7.w != 5.000000);
  if (r1.y != 0) {
    r8.x = 0.5 + r7.x;
    r8.y = r7.y * 0.25 + r7.w;
    r1.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r8.xy, r7.z).x;
  } else {
    r1.y = 1;
  }
  r1.x = r1.x + r1.y;
  r3.xyz = r0.yzw * gCSMShaderVars_shared[4].xyz + r3.xyz;
  r4.xyz = r0.yzw * gCSMShaderVars_shared[5].xyz + r4.xyz;
  r5.xyz = r0.yzw * gCSMShaderVars_shared[6].xyz + r5.xyz;
  r6.xyz = r0.yzw * gCSMShaderVars_shared[7].xyz + r6.xyz;
  r1.y = max(abs(r3.x), abs(r3.y));
  r1.z = max(abs(r4.x), abs(r4.y));
  r1.yz = cmp(r1.yz < r1.ww);
  r2.y = max(abs(r5.x), abs(r5.y));
  r2.z = max(abs(r6.x), abs(r6.y));
  r2.yz = cmp(r2.yz < r1.ww);
  r6.w = 0.875;
  r7.xyzw = r2.zzzz ? r6.xyzw : float4(0,0,0,5);
  r5.w = 0.625;
  r7.xyzw = r2.yyyy ? r5.xyzw : r7.xyzw;
  r4.w = 0.375;
  r7.xyzw = r1.zzzz ? r4.xyzw : r7.xyzw;
  r3.w = 0.125;
  r7.xyzw = r1.yyyy ? r3.xyzw : r7.xyzw;
  r1.y = cmp(r7.w != 5.000000);
  if (r1.y != 0) {
    r8.x = 0.5 + r7.x;
    r8.y = r7.y * 0.25 + r7.w;
    r1.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r8.xy, r7.z).x;
  } else {
    r1.y = 1;
  }
  r1.x = r1.x + r1.y;
  r3.xyz = r0.yzw * gCSMShaderVars_shared[4].xyz + r3.xyz;
  r4.xyz = r0.yzw * gCSMShaderVars_shared[5].xyz + r4.xyz;
  r5.xyz = r0.yzw * gCSMShaderVars_shared[6].xyz + r5.xyz;
  r6.xyz = r0.yzw * gCSMShaderVars_shared[7].xyz + r6.xyz;
  r1.y = max(abs(r3.x), abs(r3.y));
  r1.z = max(abs(r4.x), abs(r4.y));
  r1.yz = cmp(r1.yz < r1.ww);
  r2.y = max(abs(r5.x), abs(r5.y));
  r2.z = max(abs(r6.x), abs(r6.y));
  r2.yz = cmp(r2.yz < r1.ww);
  r6.w = 0.875;
  r7.xyzw = r2.zzzz ? r6.xyzw : float4(0,0,0,5);
  r5.w = 0.625;
  r7.xyzw = r2.yyyy ? r5.xyzw : r7.xyzw;
  r4.w = 0.375;
  r7.xyzw = r1.zzzz ? r4.xyzw : r7.xyzw;
  r3.w = 0.125;
  r7.xyzw = r1.yyyy ? r3.xyzw : r7.xyzw;
  r1.y = cmp(r7.w != 5.000000);
  if (r1.y != 0) {
    r8.x = 0.5 + r7.x;
    r8.y = r7.y * 0.25 + r7.w;
    r1.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r8.xy, r7.z).x;
  } else {
    r1.y = 1;
  }
  r1.x = r1.x + r1.y;
  r3.xyz = r0.yzw * gCSMShaderVars_shared[4].xyz + r3.xyz;
  r4.xyz = r0.yzw * gCSMShaderVars_shared[5].xyz + r4.xyz;
  r5.xyz = r0.yzw * gCSMShaderVars_shared[6].xyz + r5.xyz;
  r6.xyz = r0.yzw * gCSMShaderVars_shared[7].xyz + r6.xyz;
  r1.y = max(abs(r3.x), abs(r3.y));
  r1.z = max(abs(r4.x), abs(r4.y));
  r1.yz = cmp(r1.yz < r1.ww);
  r2.y = max(abs(r5.x), abs(r5.y));
  r2.z = max(abs(r6.x), abs(r6.y));
  r2.yz = cmp(r2.yz < r1.ww);
  r6.w = 0.875;
  r7.xyzw = r2.zzzz ? r6.xyzw : float4(0,0,0,5);
  r5.w = 0.625;
  r7.xyzw = r2.yyyy ? r5.xyzw : r7.xyzw;
  r4.w = 0.375;
  r7.xyzw = r1.zzzz ? r4.xyzw : r7.xyzw;
  r3.w = 0.125;
  r7.xyzw = r1.yyyy ? r3.xyzw : r7.xyzw;
  r1.y = cmp(r7.w != 5.000000);
  if (r1.y != 0) {
    r8.x = 0.5 + r7.x;
    r8.y = r7.y * 0.25 + r7.w;
    r1.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r8.xy, r7.z).x;
  } else {
    r1.y = 1;
  }
  r1.x = r1.x + r1.y;
  r3.xyz = r0.yzw * gCSMShaderVars_shared[4].xyz + r3.xyz;
  r4.xyz = r0.yzw * gCSMShaderVars_shared[5].xyz + r4.xyz;
  r5.xyz = r0.yzw * gCSMShaderVars_shared[6].xyz + r5.xyz;
  r6.xyz = r0.yzw * gCSMShaderVars_shared[7].xyz + r6.xyz;
  r1.y = max(abs(r3.x), abs(r3.y));
  r1.z = max(abs(r4.x), abs(r4.y));
  r1.yz = cmp(r1.yz < r1.ww);
  r2.y = max(abs(r5.x), abs(r5.y));
  r2.z = max(abs(r6.x), abs(r6.y));
  r2.yz = cmp(r2.yz < r1.ww);
  r6.w = 0.875;
  r7.xyzw = r2.zzzz ? r6.xyzw : float4(0,0,0,5);
  r5.w = 0.625;
  r7.xyzw = r2.yyyy ? r5.xyzw : r7.xyzw;
  r4.w = 0.375;
  r7.xyzw = r1.zzzz ? r4.xyzw : r7.xyzw;
  r3.w = 0.125;
  r7.xyzw = r1.yyyy ? r3.xyzw : r7.xyzw;
  r1.y = cmp(r7.w != 5.000000);
  if (r1.y != 0) {
    r8.x = 0.5 + r7.x;
    r8.y = r7.y * 0.25 + r7.w;
    r1.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r8.xy, r7.z).x;
  } else {
    r1.y = 1;
  }
  r1.x = r1.x + r1.y;
  r3.xyz = r0.yzw * gCSMShaderVars_shared[4].xyz + r3.xyz;
  r4.xyz = r0.yzw * gCSMShaderVars_shared[5].xyz + r4.xyz;
  r5.xyz = r0.yzw * gCSMShaderVars_shared[6].xyz + r5.xyz;
  r6.xyz = r0.yzw * gCSMShaderVars_shared[7].xyz + r6.xyz;
  r1.y = max(abs(r3.x), abs(r3.y));
  r1.z = max(abs(r4.x), abs(r4.y));
  r1.yz = cmp(r1.yz < r1.ww);
  r2.y = max(abs(r5.x), abs(r5.y));
  r2.z = max(abs(r6.x), abs(r6.y));
  r2.yz = cmp(r2.yz < r1.ww);
  r6.w = 0.875;
  r7.xyzw = r2.zzzz ? r6.xyzw : float4(0,0,0,5);
  r5.w = 0.625;
  r7.xyzw = r2.yyyy ? r5.xyzw : r7.xyzw;
  r4.w = 0.375;
  r7.xyzw = r1.zzzz ? r4.xyzw : r7.xyzw;
  r3.w = 0.125;
  r7.xyzw = r1.yyyy ? r3.xyzw : r7.xyzw;
  r1.y = cmp(r7.w != 5.000000);
  if (r1.y != 0) {
    r8.x = 0.5 + r7.x;
    r8.y = r7.y * 0.25 + r7.w;
    r1.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r8.xy, r7.z).x;
  } else {
    r1.y = 1;
  }
  r1.x = r1.x + r1.y;
  r3.xyz = r0.yzw * gCSMShaderVars_shared[4].xyz + r3.xyz;
  r4.xyz = r0.yzw * gCSMShaderVars_shared[5].xyz + r4.xyz;
  r5.xyz = r0.yzw * gCSMShaderVars_shared[6].xyz + r5.xyz;
  r6.xyz = r0.yzw * gCSMShaderVars_shared[7].xyz + r6.xyz;
  r0.y = max(abs(r3.x), abs(r3.y));
  r0.z = max(abs(r4.x), abs(r4.y));
  r0.w = max(abs(r5.x), abs(r5.y));
  r0.yzw = cmp(r0.yzw < r1.www);
  r1.y = max(abs(r6.x), abs(r6.y));
  r1.y = cmp(r1.y < r1.w);
  r6.w = 0.875;
  r6.xyzw = r1.yyyy ? r6.xyzw : float4(0,0,0,5);
  r5.w = 0.625;
  r5.xyzw = r0.wwww ? r5.xyzw : r6.xyzw;
  r4.w = 0.375;
  r4.xyzw = r0.zzzz ? r4.xyzw : r5.xyzw;
  r3.w = 0.125;
  r3.xyzw = r0.yyyy ? r3.xyzw : r4.xyzw;
  r0.y = cmp(r3.w != 5.000000);
  if (r0.y != 0) {
    r4.x = 0.5 + r3.x;
    r4.y = r3.y * 0.25 + r3.w;
    r0.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r4.xy, r3.z).x;
  } else {
    r0.y = 1;
  }
  r0.y = r1.x + r0.y;
  r0.y = 0.125 * r0.y;
  r2.x = saturate(r2.x);
  r0.z = 1 + -r2.x;
  o0.x = r0.z * r0.y + r2.x;
  o0.zw = float2(0,0);
  o0.y = r0.x;
  return;
}