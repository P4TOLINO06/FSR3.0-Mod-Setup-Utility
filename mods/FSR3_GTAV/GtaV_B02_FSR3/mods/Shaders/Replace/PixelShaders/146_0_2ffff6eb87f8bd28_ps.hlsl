// ---- FNV Hash 2ffff6eb87f8bd28

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

cbuffer lighting_globals : register(b3)
{
  float4 gDirectionalLight : packoffset(c0);
  float4 gDirectionalColour : packoffset(c1);
  int gNumForwardLights : packoffset(c2);
  float4 gLightPositionAndInvDistSqr[8] : packoffset(c3);
  float4 gLightDirectionAndFalloffExponent[8] : packoffset(c11);
  float4 gLightColourAndCapsuleExtent[8] : packoffset(c19);
  float gLightConeScale[8] : packoffset(c27);
  float gLightConeOffset[8] : packoffset(c35);
  float4 gLightNaturalAmbient0 : packoffset(c43);
  float4 gLightNaturalAmbient1 : packoffset(c44);
  float4 gLightArtificialIntAmbient0 : packoffset(c45);
  float4 gLightArtificialIntAmbient1 : packoffset(c46);
  float4 gLightArtificialExtAmbient0 : packoffset(c47);
  float4 gLightArtificialExtAmbient1 : packoffset(c48);
  float4 gDirectionalAmbientColour : packoffset(c49);
  float4 globalFogParams[5] : packoffset(c50);
  float4 globalFogColor : packoffset(c55);
  float4 globalFogColorE : packoffset(c56);
  float4 globalFogColorN : packoffset(c57);
  float4 globalFogColorMoon : packoffset(c58);
  float4 gReflectionTweaks : packoffset(c59);
}

cbuffer more_stuff : register(b5)
{
  float4 gEntitySelectColor[2] : packoffset(c0);
  float4 gAmbientOcclusionEffect : packoffset(c2);
  float4 gDynamicBakesAndWetness : packoffset(c3);
  float4 gAlphaRefVec0 : packoffset(c4);
  float4 gAlphaRefVec1 : packoffset(c5);
  float gAlphaTestRef : packoffset(c6);
  bool gTreesUseDiscard : packoffset(c6.y);
  float gReflectionMipCount : packoffset(c6.z);
  float gTransparencyAASamples : packoffset(c6.w);
  bool gUseFogRay : packoffset(c7);
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

SamplerState DiffuseSampler_s : register(s0);
SamplerState FogRaySampler_s : register(s11);
SamplerComparisonState gCSMShadowTextureSamp_s : register(s15);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> FogRaySampler : register(t11);
Texture2D<float4> gCSMShadowTexture : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  linear centroid float4 v0 : COLOR0,
  float3 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD6,
  float4 v4 : SV_Position0,
  float4 v5 : SV_ClipDistance0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float o1 : SV_Target1,
  out float o2 : SV_Target2,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[4];
  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.xy).xyzw;
  r1.x = dot(v2.xyz, v2.xyz);
  r1.x = rsqrt(r1.x);
  r1.yzw = v2.xyz * r1.xxx;
  r0.w = v0.w * r0.w;
  r2.xy = globalScalars.zy * v0.xy;
  r0.xyz = r0.xyz * r0.xyz;
  r3.xyz = gViewInverse._m30_m31_m32 + -v3.xyz;
  r2.z = dot(r3.xyz, gViewInverse._m20_m21_m22);
  r3.xyz = -gViewInverse._m30_m31_m32 + v3.xyz;
  r4.xyz = gCSMShaderVars_shared[1].xyz * r3.yyy;
  r4.xyz = r3.xxx * gCSMShaderVars_shared[0].xyz + r4.xyz;
  r4.xyz = r3.zzz * gCSMShaderVars_shared[2].xyz + r4.xyz;
  r5.xyz = r4.xyz * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
  x0[0].xyz = r5.xyz;
  r6.xyz = r4.xyz * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
  x0[1].xyz = r6.xyz;
  r7.xyz = r4.xyz * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
  x0[2].xyz = r7.xyz;
  r4.xyz = r4.xyz * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
  x0[3].xyz = r4.xyz;
  r8.yw = float2(-0.346096516,0.32848981) * gCSMResolution.zw;
  r2.w = -gCSMResolution.z * 1.5 + 1;
  r2.w = 0.5 * r2.w;
  r3.w = max(abs(r7.x), abs(r7.y));
  r3.w = cmp(r3.w < r2.w);
  r3.w = r3.w ? 2 : 3;
  r4.z = max(abs(r6.x), abs(r6.y));
  r4.z = cmp(r4.z < r2.w);
  r3.w = r4.z ? 1 : r3.w;
  r4.z = max(abs(r5.x), abs(r5.y));
  r2.w = cmp(r4.z < r2.w);
  r2.w = r2.w ? 0 : r3.w;
  r5.xyz = x0[r2.w+0].xyz;
  r2.w = (int)r2.w;
  r3.w = 0.5 + r2.w;
  r3.w = 0.25 * r3.w;
  r6.xyzw = cmp(float4(0,1,2,3) == r2.wwww);
  r6.xyzw = r6.xyzw ? float4(1,1,1,1) : 0;
  r2.w = dot(r6.xyzw, gCSMDepthBias.xyzw);
  r4.z = dot(r6.xyzw, gCSMDepthSlopeBias.xyzw);
  r6.x = 0.5 + r5.x;
  r6.y = r5.y * 0.25 + r3.w;
  r3.w = cmp(r2.w != 0.000000);
  r2.w = r5.z + -r2.w;
  r7.xyw = ddx(r6.xyy);
  r7.z = ddx(r2.w);
  r9.xyz = ddy(r6.yxy);
  r9.w = ddy(r2.w);
  r5.xy = r9.yw * r7.yw;
  r10.xy = r7.xz * r9.xz + -r5.xy;
  r4.w = 1 / r10.x;
  r5.x = r9.y * r7.z;
  r10.z = r7.x * r9.w + -r5.x;
  r5.xy = r10.yz * r4.ww;
  r5.xy = max(float2(0,0), r5.xy);
  r5.xy = min(float2(0.5,0.5), r5.xy);
  r2.w = -r4.z * r5.x + r2.w;
  r2.w = -r4.z * r5.y + r2.w;
  r8.z = r3.w ? r2.w : r5.z;
  r6.z = 0;
  r5.xyz = r8.ywz + r6.xyz;
  r8.xy = float2(-0.799291492,0.201740593) * gCSMResolution.zw;
  r7.xyz = r8.xyz + r6.xyz;
  r8.xy = float2(-0.0311755072,0.179337755) * gCSMResolution.zw;
  r9.xyz = r8.xyz + r6.xyz;
  r8.xy = float2(0.514749467,0.253502458) * gCSMResolution.zw;
  r10.xyz = r8.xyz + r6.xyz;
  r8.xy = float2(-0.0728697181,0.00809734128) * gCSMResolution.zw;
  r11.xyz = r8.xyz + r6.xyz;
  r8.xy = float2(-0.96978128,0.0345216095) * gCSMResolution.zw;
  r12.xyz = r8.xyz + r6.xyz;
  r8.xy = float2(0.545546651,0.0241285414) * gCSMResolution.zw;
  r13.xyz = r8.xyz + r6.xyz;
  r8.xy = float2(-0.0289061088,-0.136784583) * gCSMResolution.zw;
  r14.xyz = r8.xyz + r6.xyz;
  r8.xy = float2(-0.47951147,-0.244832873) * gCSMResolution.zw;
  r15.xyz = r8.xyz + r6.xyz;
  r8.xy = float2(0.758788407,-0.112109199) * gCSMResolution.zw;
  r16.xyz = r8.xyz + r6.xyz;
  r8.xy = float2(0.339352578,-0.249327824) * gCSMResolution.zw;
  r17.xyz = r8.xyz + r6.xyz;
  r8.xy = float2(1.07059765,0.208122596) * gCSMResolution.zw;
  r18.xyz = r8.xyz + r6.xyz;
  r8.xy = float2(1.29403818,-0.0180776753) * gCSMResolution.zw;
  r19.xyz = r8.xyz + r6.xyz;
  r8.xy = float2(-0.747563064,-0.113974348) * gCSMResolution.zw;
  r20.xyz = r8.xyz + r6.xyz;
  r8.xy = float2(0.94772172,-0.248763546) * gCSMResolution.zw;
  r21.xyz = r8.xyz + r6.xyz;
  r8.xy = float2(-1.34315288,-0.088584058) * gCSMResolution.zw;
  r6.xyz = r8.xyz + r6.xyz;
  r5.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r5.xy, r5.z).x;
  r5.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r7.xy, r7.z).x;
  r5.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r9.xy, r9.z).x;
  r5.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r10.xy, r10.z).x;
  r7.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r11.xy, r11.z).x;
  r7.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r12.xy, r12.z).x;
  r7.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r13.xy, r13.z).x;
  r7.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r14.xy, r14.z).x;
  r8.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r15.xy, r15.z).x;
  r8.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r16.xy, r16.z).x;
  r8.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r17.xy, r17.z).x;
  r8.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r18.xy, r18.z).x;
  r9.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r19.xy, r19.z).x;
  r9.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r20.xy, r20.z).x;
  r9.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r21.xy, r21.z).x;
  r9.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r6.xy, r6.z).x;
  r5.xyzw = r7.xyzw + r5.xyzw;
  r5.xyzw = r5.xyzw + r8.xyzw;
  r5.xyzw = r5.xyzw + r9.xyzw;
  r2.w = dot(r5.xyzw, float4(1,1,1,1));
  r2.z = saturate(r2.z * gCSMShaderVars_shared[0].w + gCSMShaderVars_shared[1].w);
  r3.w = max(abs(r4.x), abs(r4.y));
  r3.w = saturate(r3.w * 15 + -6.30000019);
  r2.z = 1 + -r2.z;
  r2.z = r2.z * r3.w;
  r2.z = r2.w * 0.0625 + r2.z;
  r2.xyz = r2.xyz * r2.xyz;
  r2.z = min(1, r2.z);
  r2.w = saturate(v3.z * gCSMShaderVars_shared[3].x + gCSMShaderVars_shared[3].y);
  r2.w = sqrt(r2.w);
  r2.w = gCSMShaderVars_shared[3].z * r2.w;
  r2.z = r2.w * -r2.z + r2.z;
  r2.w = saturate(dot(r1.yzw, -gDirectionalLight.xyz));
  r4.xyz = r2.www * r0.xyz;
  r4.xyz = gDirectionalColour.xyz * r4.xyz;
  r1.x = v2.z * r1.x + gLightNaturalAmbient0.w;
  r1.x = gLightNaturalAmbient1.w * r1.x;
  r1.x = max(0, r1.x);
  r5.xyz = gLightArtificialExtAmbient0.xyz * r1.xxx + gLightArtificialExtAmbient1.xyz;
  r2.w = 1 + -globalScalars2.z;
  r6.xyz = gLightArtificialIntAmbient0.xyz * r1.xxx + gLightArtificialIntAmbient1.xyz;
  r6.xyz = globalScalars2.zzz * r6.xyz;
  r5.xyz = r5.xyz * r2.www + r6.xyz;
  r5.xyz = r5.xyz * r2.yyy;
  r6.xyz = gLightNaturalAmbient0.xyz * r1.xxx + gLightNaturalAmbient1.xyz;
  r7.x = gLightArtificialIntAmbient1.w;
  r7.y = gLightArtificialExtAmbient0.w;
  r7.z = gLightArtificialExtAmbient1.w;
  r1.x = saturate(dot(r7.xyz, r1.yzw));
  r1.xyz = gDirectionalAmbientColour.xyz * r1.xxx + r6.xyz;
  r1.xyz = r1.xyz * r2.xxx + r5.xyz;
  r0.xyz = r1.xyz * r0.xyz;
  r0.xyz = r4.xyz * r2.zzz + r0.xyz;
  r0.w = globalScalars.x * r0.w;
  if (gUseFogRay != 0) {
    r1.x = dot(r3.xyz, r3.xyz);
    r1.y = sqrt(r1.x);
    r1.z = -globalFogParams[0].x + r1.y;
    r1.z = max(0, r1.z);
    r1.y = r1.z / r1.y;
    r1.y = r3.z * r1.y;
    r1.w = globalFogParams[2].z * r1.y;
    r1.y = cmp(0.00999999978 < abs(r1.y));
    r2.x = -1.44269502 * r1.w;
    r2.x = exp2(r2.x);
    r2.x = 1 + -r2.x;
    r1.w = r2.x / r1.w;
    r1.y = r1.y ? r1.w : 1;
    r1.w = globalFogParams[1].w * r1.z;
    r1.y = r1.w * r1.y;
    r1.y = min(1, r1.y);
    r1.y = 1.44269502 * r1.y;
    r1.y = exp2(r1.y);
    r1.y = min(1, r1.y);
    r1.y = 1 + -r1.y;
    r1.w = globalFogParams[2].y * r1.y;
    r1.x = rsqrt(r1.x);
    r2.xyz = r3.xyz * r1.xxx;
    r1.x = saturate(dot(r2.xyz, globalFogParams[4].xyz));
    r1.x = log2(r1.x);
    r1.x = globalFogParams[4].w * r1.x;
    r1.x = exp2(r1.x);
    r2.x = saturate(dot(r2.xyz, globalFogParams[3].xyz));
    r2.x = log2(r2.x);
    r2.x = globalFogParams[3].w * r2.x;
    r2.x = exp2(r2.x);
    r1.y = -r1.y * globalFogParams[2].y + 1;
    r1.y = globalFogParams[1].y * r1.y;
    r2.y = -globalFogParams[2].x + r1.z;
    r2.y = max(0, r2.y);
    r2.y = globalFogParams[1].x * r2.y;
    r2.y = 1.44269502 * r2.y;
    r2.y = exp2(r2.y);
    r2.y = 1 + -r2.y;
    r1.w = saturate(r1.y * r2.y + r1.w);
    r1.z = -globalFogParams[1].z * r1.z;
    r1.z = 1.44269502 * r1.z;
    r1.z = exp2(r1.z);
    r1.z = 1 + -r1.z;
    r2.yzw = globalFogColorMoon.xyz + -globalFogColorE.xyz;
    r2.yzw = r1.xxx * r2.yzw + globalFogColorE.xyz;
    r4.xyz = globalFogColor.xyz + -r2.yzw;
    r2.xyz = r2.xxx * r4.xyz + r2.yzw;
    r2.xyz = -globalFogColorN.xyz + r2.xyz;
    r2.xyz = r1.zzz * r2.xyz + globalFogColorN.xyz;
    r4.x = globalFogColor.w;
    r4.y = globalFogColorE.w;
    r4.z = globalFogColorN.w;
    r4.xyz = r4.xyz + -r2.xyz;
    r1.xyz = r1.yyy * r4.xyz + r2.xyz;
    r2.x = cmp(0 < gGlobalFogIntensity);
    if (r2.x != 0) {
      r2.xy = globalScreenSize.zw * v4.xy;
      r2.xyzw = FogRaySampler.Sample(FogRaySampler_s, r2.xy).xyzw;
      r2.x = -1 + r2.x;
      r2.x = saturate(gGlobalFogIntensity * r2.x + 1);
    } else {
      r2.x = 1;
    }
    r1.xyz = r1.xyz * r2.xxx + -r0.xyz;
    r1.xyz = r1.www * r1.xyz + r0.xyz;
  } else {
    r1.w = dot(r3.xyz, r3.xyz);
    r2.x = sqrt(r1.w);
    r2.y = -globalFogParams[0].x + r2.x;
    r2.y = max(0, r2.y);
    r2.x = r2.y / r2.x;
    r2.x = r3.z * r2.x;
    r2.z = globalFogParams[2].z * r2.x;
    r2.x = cmp(0.00999999978 < abs(r2.x));
    r2.w = -1.44269502 * r2.z;
    r2.w = exp2(r2.w);
    r2.w = 1 + -r2.w;
    r2.z = r2.w / r2.z;
    r2.x = r2.x ? r2.z : 1;
    r2.z = globalFogParams[1].w * r2.y;
    r2.x = r2.z * r2.x;
    r2.x = min(1, r2.x);
    r2.x = 1.44269502 * r2.x;
    r2.x = exp2(r2.x);
    r2.x = min(1, r2.x);
    r2.x = 1 + -r2.x;
    r2.z = globalFogParams[2].y * r2.x;
    r1.w = rsqrt(r1.w);
    r3.xyz = r3.xyz * r1.www;
    r1.w = saturate(dot(r3.xyz, globalFogParams[4].xyz));
    r1.w = log2(r1.w);
    r1.w = globalFogParams[4].w * r1.w;
    r1.w = exp2(r1.w);
    r2.w = saturate(dot(r3.xyz, globalFogParams[3].xyz));
    r2.w = log2(r2.w);
    r2.w = globalFogParams[3].w * r2.w;
    r2.w = exp2(r2.w);
    r2.x = -r2.x * globalFogParams[2].y + 1;
    r2.x = globalFogParams[1].y * r2.x;
    r3.x = -globalFogParams[2].x + r2.y;
    r3.x = max(0, r3.x);
    r3.x = globalFogParams[1].x * r3.x;
    r3.x = 1.44269502 * r3.x;
    r3.x = exp2(r3.x);
    r3.x = 1 + -r3.x;
    r2.z = saturate(r2.x * r3.x + r2.z);
    r2.y = -globalFogParams[1].z * r2.y;
    r2.y = 1.44269502 * r2.y;
    r2.y = exp2(r2.y);
    r2.y = 1 + -r2.y;
    r3.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
    r3.xyz = r1.www * r3.xyz + globalFogColorE.xyz;
    r4.xyz = globalFogColor.xyz + -r3.xyz;
    r3.xyz = r2.www * r4.xyz + r3.xyz;
    r3.xyz = -globalFogColorN.xyz + r3.xyz;
    r3.xyz = r2.yyy * r3.xyz + globalFogColorN.xyz;
    r4.x = globalFogColor.w;
    r4.y = globalFogColorE.w;
    r4.z = globalFogColorN.w;
    r4.xyz = r4.xyz + -r3.xyz;
    r2.xyw = r2.xxx * r4.xyz + r3.xyz;
    r2.xyw = r2.xyw + -r0.xyz;
    r1.xyz = r2.zzz * r2.xyw + r0.xyz;
  }
  o0.xyz = globalScalars3.zzz * r1.xyz;
  r0.x = cmp(0.300000012 < r0.w);
  r0.x = r0.x ? 1.000000 : 0;
  o1.x = v1.z * r0.x;
  o0.w = r0.w;
  o2.x = r0.x;
  return;
}