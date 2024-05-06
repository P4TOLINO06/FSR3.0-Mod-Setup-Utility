// ---- FNV Hash f02ec6d0ffa998ef

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

cbuffer vehiclecommonlocals : register(b11)
{
  float3 matDiffuseColor : packoffset(c0);
  float4 matDiffuseColor2 : packoffset(c1);
  float4 matDiffuseColorTint : packoffset(c2);
  float4 dirtLevelMod : packoffset(c3);
  float3 dirtColor : packoffset(c4);
  float3 specMapIntMask : packoffset(c5);
  float reflectivePower : packoffset(c5.w);
  float envEffThickness : packoffset(c6);
  float2 envEffScale : packoffset(c6.y);
  float envEffTexTileUV : packoffset(c6.w);
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
SamplerState ReflectionSampler_s : register(s1);
SamplerState DirtSampler_s : register(s3);
SamplerState SpecSampler_s : register(s4);
SamplerState FogRaySampler_s : register(s11);
SamplerComparisonState gCSMShadowTextureSamp_s : register(s15);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> ReflectionSampler : register(t1);
Texture2D<float4> DirtSampler : register(t3);
Texture2D<float4> SpecSampler : register(t4);
Texture2D<float4> FogRaySampler : register(t11);
Texture2D<float4> gCSMShadowTexture : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  linear sample float4 v0 : TEXCOORD0,
  linear sample float4 v1 : TEXCOORD1,
  linear sample float4 v2 : TEXCOORD2,
  float4 v3 : TEXCOORD3,
  linear sample float4 v4 : TEXCOORD6,
  linear sample float4 v5 : TEXCOORD8,
  float4 v6 : SV_Position0,
  float4 v7 : SV_ClipDistance0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[4];
  r0.x = min(0.200000003, dirtLevelMod.x);
  r1.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v0.xy).xyzw;
  r0.y = dot(v1.xyz, v1.xyz);
  r0.y = rsqrt(r0.y);
  r2.xyz = v1.xyz * r0.yyy;
  r3.xyzw = SpecSampler.Sample(SpecSampler_s, v0.xy).xyzw;
  r3.xy = r3.xy * r3.xy;
  r0.z = dot(r3.xyz, specMapIntMask.xyz);
  r0.z = v4.x * r0.z;
  r3.xyz = float3(-1,-1,-1) + matDiffuseColorTint.xyz;
  r3.xyz = v4.www * r3.xyz + float3(1,1,1);
  r1.xyz = r3.xyz * r1.xyz;
  r0.w = saturate(matDiffuseColorTint.w * v4.w + r1.w);
  r1.xyz = matDiffuseColor.xyz * r1.xyz;
  r1.xyz = v4.xxx * r1.xyz;
  r3.xy = globalScalars.zy * v4.xx;
  r1.w = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r1.w = r3.y * r1.w;
  r0.z = v1.w * r0.z;
  r0.z = 0.0500000007 * r0.z;
  r3.yz = float2(1,2) + -dirtLevelMod.zz;
  r2.w = v4.z * r3.y;
  r4.xy = v0.zw * r3.zz;
  r4.xyzw = DirtSampler.Sample(DirtSampler_s, r4.xy).xyzw;
  r3.z = dirtLevelMod.z * gDynamicBakesAndWetness.z;
  r4.w = r4.z + -r4.x;
  r4.x = r3.z * r4.w + r4.x;
  r4.xy = r4.xy * r0.xx;
  r3.z = v4.z * r3.y + -1;
  r3.y = r3.y * r3.z + 1;
  r3.z = r4.x * r3.y;
  r5.xyz = dirtColor.xyz * dirtLevelMod.yyy + -r1.xyz;
  r1.xyz = r3.zzz * r5.xyz + r1.xyz;
  r0.x = r2.w * r0.x;
  r5.xyz = r4.zzz + -r1.xyz;
  r1.xyz = r0.xxx * r5.xyz + r1.xyz;
  r0.x = r4.x * r3.y + r0.w;
  r0.w = -r4.y * r3.y + 1;
  r0.z = saturate(r0.z * r0.w);
  r4.xyz = gViewInverse._m30_m31_m32 + -v2.xyz;
  r0.w = dot(r4.xyz, r4.xyz);
  r0.w = rsqrt(r0.w);
  r5.xyz = r4.xyz * r0.www;
  r6.xyz = r4.xyz * r0.www + -gDirectionalLight.xyz;
  r2.w = dot(r6.xyz, r6.xyz);
  r2.w = rsqrt(r2.w);
  r6.xyz = r6.xyz * r2.www;
  r2.w = r3.x * r3.x;
  r1.xyzw = r1.xyzw * r1.xyzw;
  r3.x = r3.w * 512 + -500;
  r3.x = max(0, r3.x);
  r3.y = r3.w * 512 + -r3.x;
  r3.x = 558 * r3.x;
  r3.x = r3.y * 3 + r3.x;
  r3.yzw = -gViewInverse._m30_m31_m32 + v2.xyz;
  r7.xyz = gCSMShaderVars_shared[1].xyz * r3.zzz;
  r7.xyz = r3.yyy * gCSMShaderVars_shared[0].xyz + r7.xyz;
  r3.yzw = r3.www * gCSMShaderVars_shared[2].xyz + r7.xyz;
  r7.xyz = r3.yzw * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
  x0[0].xyz = r7.xyz;
  r8.xyz = r3.yzw * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
  x0[1].xyz = r8.xyz;
  r9.xyz = r3.yzw * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
  x0[2].xyz = r9.xyz;
  r3.yzw = r3.yzw * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
  x0[3].xyz = r3.yzw;
  r3.y = -gCSMResolution.z * 1.5 + 1;
  r3.y = 0.5 * r3.y;
  r3.z = max(abs(r9.x), abs(r9.y));
  r3.z = cmp(r3.z < r3.y);
  r3.z = r3.z ? 2 : 3;
  r3.w = max(abs(r8.x), abs(r8.y));
  r3.w = cmp(r3.w < r3.y);
  r3.z = r3.w ? 1 : r3.z;
  r3.w = max(abs(r7.x), abs(r7.y));
  r3.y = cmp(r3.w < r3.y);
  r3.y = r3.y ? 0 : r3.z;
  r7.xyz = x0[r3.y+0].xyz;
  r3.y = (int)r3.y;
  r3.z = 0.5 + r3.y;
  r3.z = 0.25 * r3.z;
  r8.xyzw = cmp(float4(0,1,2,3) == r3.yyyy);
  r8.xyzw = r8.xyzw ? float4(1,1,1,1) : 0;
  r3.y = dot(r8.xyzw, gCSMDepthBias.xyzw);
  r3.w = dot(r8.xyzw, gCSMDepthSlopeBias.xyzw);
  r8.x = 0.5 + r7.x;
  r8.y = r7.y * 0.25 + r3.z;
  r3.z = cmp(r3.y != 0.000000);
  r3.y = r7.z + -r3.y;
  r9.xyw = ddx(r8.xyy);
  r9.z = ddx(r3.y);
  r10.xyz = ddy(r8.yxy);
  r10.w = ddy(r3.y);
  r7.xy = r10.yw * r9.yw;
  r11.xy = r9.xz * r10.xz + -r7.xy;
  r4.w = 1 / r11.x;
  r5.w = r10.y * r9.z;
  r11.z = r9.x * r10.w + -r5.w;
  r7.xy = r11.yz * r4.ww;
  r7.xy = max(float2(0,0), r7.xy);
  r7.xy = min(float2(0.5,0.5), r7.xy);
  r3.y = -r3.w * r7.x + r3.y;
  r3.y = -r3.w * r7.y + r3.y;
  r3.y = r3.z ? r3.y : r7.z;
  r3.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r8.xy, r3.y).x;
  r3.z = dot(r2.xyz, -gDirectionalLight.xyz);
  r3.w = saturate(r3.z);
  r3.w = r3.w + -abs(r3.z);
  r3.z = r0.x * r3.w + abs(r3.z);
  r7.x = saturate(dot(r5.xyz, r2.xyz));
  r7.y = saturate(dot(r6.xyz, -gDirectionalLight.xyz));
  r7.xy = float2(1,1) + -r7.xy;
  r7.zw = r7.xy * r7.xy;
  r7.zw = r7.zw * r7.zw;
  r7.yw = r7.zw * r7.xy;
  r8.xy = float2(2,9.99999994e-09) + r3.xx;
  r3.w = 0.125 * r8.x;
  r4.w = max(r7.y, r0.x);
  r5.w = r7.z * r7.x + -1;
  r5.w = r4.w * r5.w + 1;
  r5.w = -r0.z * r5.w + 1;
  r6.x = dot(r2.xyz, r6.xyz);
  r6.x = saturate(9.99999994e-09 + r6.x);
  r6.x = log2(r6.x);
  r6.x = r8.y * r6.x;
  r6.x = exp2(r6.x);
  r6.x = r6.x * r7.w;
  r6.x = r6.x * r3.w;
  r6.x = r6.x * r0.z;
  r6.x = r6.x * r3.z;
  r3.z = r5.w * r3.z;
  r6.xyz = r1.xyz * r3.zzz + r6.xxx;
  r6.xyz = gDirectionalColour.xyz * r6.xyz;
  r3.z = cmp(0 >= gNumForwardLights);
  if (r3.z == 0) {
    r6.w = cmp(gLightColourAndCapsuleExtent[0].w == 0.000000);
    r7.xyz = gLightPositionAndInvDistSqr[0].xyz + -v2.xyz;
    r8.xzw = -gLightPositionAndInvDistSqr[0].xyz + v2.xyz;
    r7.w = dot(r8.xzw, gLightDirectionAndFalloffExponent[0].xyz);
    r8.x = 9.99999975e-05 + gLightColourAndCapsuleExtent[0].w;
    r7.w = saturate(r7.w / r8.x);
    r7.w = gLightColourAndCapsuleExtent[0].w * r7.w;
    r8.xzw = gLightDirectionAndFalloffExponent[0].xyz * r7.www + gLightPositionAndInvDistSqr[0].xyz;
    r8.xzw = -v2.xyz + r8.xzw;
    r7.xyz = r6.www ? r7.xyz : r8.xzw;
    r6.w = dot(r7.xyz, r7.xyz);
    r7.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r7.xyz;
    r7.w = dot(r7.xyz, r7.xyz);
    r7.w = rsqrt(r7.w);
    r7.xyz = r7.xyz * r7.www;
    r6.w = saturate(-r6.w * gLightPositionAndInvDistSqr[0].w + 1);
    r7.w = 1 + -gLightDirectionAndFalloffExponent[0].w;
    r7.w = r7.w * r6.w + gLightDirectionAndFalloffExponent[0].w;
    r6.w = r6.w / r7.w;
    r7.w = dot(r7.xyz, -gLightDirectionAndFalloffExponent[0].xyz);
    r7.w = saturate(r7.w * gLightConeScale[0] + gLightConeOffset[0]);
    r8.x = dot(r7.xyz, r2.xyz);
    r8.z = saturate(r8.x);
    r8.z = r8.z + -abs(r8.x);
    r8.x = r0.x * r8.z + abs(r8.x);
    r7.w = r8.x * r7.w;
    r8.x = r7.w * r6.w;
    r8.xzw = gLightColourAndCapsuleExtent[0].xyz * r8.xxx;
    r8.xzw = r8.xzw * r1.xyz;
    r7.xyz = r4.xyz * r0.www + r7.xyz;
    r9.x = dot(r7.xyz, r7.xyz);
    r9.x = rsqrt(r9.x);
    r7.xyz = r9.xxx * r7.xyz;
    r9.x = saturate(dot(r7.xyz, r5.xyz));
    r9.x = 1 + -r9.x;
    r9.y = r9.x * r9.x;
    r9.y = r9.y * r9.y;
    r9.x = r9.x * r9.y;
    r7.x = saturate(dot(r7.xyz, r2.xyz));
    r7.x = log2(r7.x);
    r7.x = r8.y * r7.x;
    r7.x = exp2(r7.x);
    r7.x = r9.x * r7.x;
    r7.x = r7.x * r7.w;
    r6.w = r7.x * r6.w;
    r6.w = r6.w * r3.w;
    r7.xyz = gLightColourAndCapsuleExtent[0].xyz * r6.www;
  } else {
    r8.xzw = float3(0,0,0);
    r7.xyz = float3(0,0,0);
  }
  r6.w = cmp(0 < gNumForwardLights);
  if (r6.w != 0) {
    r7.w = cmp(1 >= gNumForwardLights);
    r6.w = (int)r3.z | (int)r6.w;
    r3.z = r7.w ? r6.w : r3.z;
    if (r3.z == 0) {
      r6.w = cmp(gLightColourAndCapsuleExtent[1].w == 0.000000);
      r9.xyz = gLightPositionAndInvDistSqr[1].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[1].xyz + v2.xyz;
      r7.w = dot(r10.xyz, gLightDirectionAndFalloffExponent[1].xyz);
      r9.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[1].w;
      r7.w = saturate(r7.w / r9.w);
      r7.w = gLightColourAndCapsuleExtent[1].w * r7.w;
      r10.xyz = gLightDirectionAndFalloffExponent[1].xyz * r7.www + gLightPositionAndInvDistSqr[1].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r9.xyz = r6.www ? r9.xyz : r10.xyz;
      r6.w = dot(r9.xyz, r9.xyz);
      r9.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r9.xyz;
      r7.w = dot(r9.xyz, r9.xyz);
      r7.w = rsqrt(r7.w);
      r9.xyz = r9.xyz * r7.www;
      r6.w = saturate(-r6.w * gLightPositionAndInvDistSqr[1].w + 1);
      r7.w = 1 + -gLightDirectionAndFalloffExponent[1].w;
      r7.w = r7.w * r6.w + gLightDirectionAndFalloffExponent[1].w;
      r6.w = r6.w / r7.w;
      r7.w = dot(r9.xyz, -gLightDirectionAndFalloffExponent[1].xyz);
      r7.w = saturate(r7.w * gLightConeScale[1] + gLightConeOffset[1]);
      r9.w = dot(r9.xyz, r2.xyz);
      r10.x = saturate(r9.w);
      r10.x = r10.x + -abs(r9.w);
      r9.w = r0.x * r10.x + abs(r9.w);
      r7.w = r9.w * r7.w;
      r9.w = r7.w * r6.w;
      r10.xyz = gLightColourAndCapsuleExtent[1].xyz * r9.www;
      r8.xzw = r10.xyz * r1.xyz + r8.xzw;
      r9.xyz = r4.xyz * r0.www + r9.xyz;
      r9.w = dot(r9.xyz, r9.xyz);
      r9.w = rsqrt(r9.w);
      r9.xyz = r9.xyz * r9.www;
      r9.w = saturate(dot(r9.xyz, r5.xyz));
      r9.w = 1 + -r9.w;
      r10.x = r9.w * r9.w;
      r10.x = r10.x * r10.x;
      r9.w = r10.x * r9.w;
      r9.x = saturate(dot(r9.xyz, r2.xyz));
      r9.x = log2(r9.x);
      r9.x = r9.x * r8.y;
      r9.x = exp2(r9.x);
      r9.x = r9.w * r9.x;
      r7.w = r9.x * r7.w;
      r6.w = r7.w * r6.w;
      r6.w = r6.w * r3.w;
      r7.xyz = r6.www * gLightColourAndCapsuleExtent[1].xyz + r7.xyz;
    }
  } else {
    r3.z = -1;
  }
  if (r3.z == 0) {
    r6.w = cmp(2 >= gNumForwardLights);
    r3.z = (int)r3.z | (int)r6.w;
    if (r3.z == 0) {
      r6.w = cmp(gLightColourAndCapsuleExtent[2].w == 0.000000);
      r9.xyz = gLightPositionAndInvDistSqr[2].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[2].xyz + v2.xyz;
      r7.w = dot(r10.xyz, gLightDirectionAndFalloffExponent[2].xyz);
      r9.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[2].w;
      r7.w = saturate(r7.w / r9.w);
      r7.w = gLightColourAndCapsuleExtent[2].w * r7.w;
      r10.xyz = gLightDirectionAndFalloffExponent[2].xyz * r7.www + gLightPositionAndInvDistSqr[2].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r9.xyz = r6.www ? r9.xyz : r10.xyz;
      r6.w = dot(r9.xyz, r9.xyz);
      r9.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r9.xyz;
      r7.w = dot(r9.xyz, r9.xyz);
      r7.w = rsqrt(r7.w);
      r9.xyz = r9.xyz * r7.www;
      r6.w = saturate(-r6.w * gLightPositionAndInvDistSqr[2].w + 1);
      r7.w = 1 + -gLightDirectionAndFalloffExponent[2].w;
      r7.w = r7.w * r6.w + gLightDirectionAndFalloffExponent[2].w;
      r6.w = r6.w / r7.w;
      r7.w = dot(r9.xyz, -gLightDirectionAndFalloffExponent[2].xyz);
      r7.w = saturate(r7.w * gLightConeScale[2] + gLightConeOffset[2]);
      r9.w = dot(r9.xyz, r2.xyz);
      r10.x = saturate(r9.w);
      r10.x = r10.x + -abs(r9.w);
      r9.w = r0.x * r10.x + abs(r9.w);
      r7.w = r9.w * r7.w;
      r9.w = r7.w * r6.w;
      r10.xyz = gLightColourAndCapsuleExtent[2].xyz * r9.www;
      r8.xzw = r10.xyz * r1.xyz + r8.xzw;
      r9.xyz = r4.xyz * r0.www + r9.xyz;
      r9.w = dot(r9.xyz, r9.xyz);
      r9.w = rsqrt(r9.w);
      r9.xyz = r9.xyz * r9.www;
      r9.w = saturate(dot(r9.xyz, r5.xyz));
      r9.w = 1 + -r9.w;
      r10.x = r9.w * r9.w;
      r10.x = r10.x * r10.x;
      r9.w = r10.x * r9.w;
      r9.x = saturate(dot(r9.xyz, r2.xyz));
      r9.x = log2(r9.x);
      r9.x = r9.x * r8.y;
      r9.x = exp2(r9.x);
      r9.x = r9.w * r9.x;
      r7.w = r9.x * r7.w;
      r6.w = r7.w * r6.w;
      r6.w = r6.w * r3.w;
      r7.xyz = r6.www * gLightColourAndCapsuleExtent[2].xyz + r7.xyz;
    }
  } else {
    r3.z = -1;
  }
  if (r3.z == 0) {
    r6.w = cmp(3 >= gNumForwardLights);
    r3.z = (int)r3.z | (int)r6.w;
    if (r3.z == 0) {
      r3.z = cmp(gLightColourAndCapsuleExtent[3].w == 0.000000);
      r9.xyz = gLightPositionAndInvDistSqr[3].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[3].xyz + v2.xyz;
      r6.w = dot(r10.xyz, gLightDirectionAndFalloffExponent[3].xyz);
      r7.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[3].w;
      r6.w = saturate(r6.w / r7.w);
      r6.w = gLightColourAndCapsuleExtent[3].w * r6.w;
      r10.xyz = gLightDirectionAndFalloffExponent[3].xyz * r6.www + gLightPositionAndInvDistSqr[3].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r9.xyz = r3.zzz ? r9.xyz : r10.xyz;
      r3.z = dot(r9.xyz, r9.xyz);
      r9.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r9.xyz;
      r6.w = dot(r9.xyz, r9.xyz);
      r6.w = rsqrt(r6.w);
      r9.xyz = r9.xyz * r6.www;
      r3.z = saturate(-r3.z * gLightPositionAndInvDistSqr[3].w + 1);
      r6.w = 1 + -gLightDirectionAndFalloffExponent[3].w;
      r6.w = r6.w * r3.z + gLightDirectionAndFalloffExponent[3].w;
      r3.z = r3.z / r6.w;
      r6.w = dot(r9.xyz, -gLightDirectionAndFalloffExponent[3].xyz);
      r6.w = saturate(r6.w * gLightConeScale[3] + gLightConeOffset[3]);
      r7.w = dot(r9.xyz, r2.xyz);
      r9.w = saturate(r7.w);
      r9.w = r9.w + -abs(r7.w);
      r0.x = r0.x * r9.w + abs(r7.w);
      r0.x = r0.x * r6.w;
      r6.w = r0.x * r3.z;
      r10.xyz = gLightColourAndCapsuleExtent[3].xyz * r6.www;
      r8.xzw = r10.xyz * r1.xyz + r8.xzw;
      r4.xyz = r4.xyz * r0.www + r9.xyz;
      r0.w = dot(r4.xyz, r4.xyz);
      r0.w = rsqrt(r0.w);
      r4.xyz = r4.xyz * r0.www;
      r0.w = saturate(dot(r4.xyz, r5.xyz));
      r0.w = 1 + -r0.w;
      r6.w = r0.w * r0.w;
      r6.w = r6.w * r6.w;
      r0.w = r6.w * r0.w;
      r4.x = saturate(dot(r4.xyz, r2.xyz));
      r4.x = log2(r4.x);
      r4.x = r8.y * r4.x;
      r4.x = exp2(r4.x);
      r0.w = r4.x * r0.w;
      r0.x = r0.w * r0.x;
      r0.x = r0.x * r3.z;
      r0.x = r0.x * r3.w;
      r7.xyz = r0.xxx * gLightColourAndCapsuleExtent[3].xyz + r7.xyz;
    }
  }
  r0.x = r5.w * r5.w;
  r0.z = r0.z * r0.z;
  r4.xyz = r0.zzz * r7.xyz;
  r0.xzw = r0.xxx * r8.xzw + r4.xyz;
  r0.xzw = r6.xyz * r3.yyy + r0.xzw;
  r0.y = v1.z * r0.y + gLightNaturalAmbient0.w;
  r0.y = gLightNaturalAmbient1.w * r0.y;
  r0.y = max(0, r0.y);
  r3.yzw = gLightArtificialExtAmbient0.xyz * r0.yyy + gLightArtificialExtAmbient1.xyz;
  r4.x = 1 + -globalScalars2.z;
  r6.xyz = gLightArtificialIntAmbient0.xyz * r0.yyy + gLightArtificialIntAmbient1.xyz;
  r6.xyz = globalScalars2.zzz * r6.xyz;
  r3.yzw = r3.yzw * r4.xxx + r6.xyz;
  r3.yzw = r3.yzw * r1.www;
  r4.xyz = gLightNaturalAmbient0.xyz * r0.yyy + gLightNaturalAmbient1.xyz;
  r6.x = gLightArtificialIntAmbient1.w;
  r6.y = gLightArtificialExtAmbient0.w;
  r6.z = gLightArtificialExtAmbient1.w;
  r0.y = saturate(dot(r6.xyz, r2.xyz));
  r4.xyz = gDirectionalAmbientColour.xyz * r0.yyy + r4.xyz;
  r3.yzw = r4.xyz * r2.www + r3.yzw;
  r3.yzw = r3.yzw * r5.www;
  r0.xyz = r3.yzw * r1.xyz + r0.xzw;
  r0.w = 1 + -r5.w;
  r1.x = dot(-r5.xyz, r2.xyz);
  r1.x = r1.x + r1.x;
  r1.xyz = r2.xyz * -r1.xxx + -r5.xyz;
  r2.xy = saturate(float2(0.000666666718,0.00177619897) * r3.xx);
  r2.x = 1 + -r2.x;
  r2.z = -5 + gReflectionMipCount;
  r3.x = gReflectionMipCount * r2.x;
  r3.x = cmp(r3.x < r2.z);
  r3.y = r2.x * gReflectionMipCount + -5;
  r2.x = r2.x * r2.x;
  r2.x = r2.x * 5 + r2.z;
  r2.x = r3.x ? r3.y : r2.x;
  r3.xyz = float3(-0.25,0.5,0.25) * r1.xyx;
  r1.x = 1 + abs(r1.z);
  r3.xyz = r3.xyz / r1.xxx;
  r3.xyz = float3(0.75,0.5,0.25) + -r3.xyz;
  r1.x = cmp(0 < r1.z);
  r1.xy = r1.xx ? r3.xy : r3.zy;
  r3.xyzw = ReflectionSampler.SampleLevel(ReflectionSampler_s, r1.xy, r2.x).xyzw;
  r1.x = max(r2.w, r1.w);
  r1.xyz = r3.xyz * r1.xxx;
  r2.xyz = r1.xyz * r2.yyy;
  r2.xyz = float3(0.681690097,0.681690097,0.681690097) * r2.xyz;
  r1.xyz = r1.xyz * float3(0.318309903,0.318309903,0.318309903) + r2.xyz;
  r0.xyz = r1.xyz * r0.www + r0.xyz;
  o0.w = saturate(globalScalars.x * r4.w);
  r0.w = cmp(0 < gGlobalFogIntensity);
  if (r0.w != 0) {
    r1.xy = globalScreenSize.zw * v6.xy;
    r1.xyzw = FogRaySampler.Sample(FogRaySampler_s, r1.xy).xyzw;
    r0.w = -1 + r1.x;
    r0.w = saturate(gGlobalFogIntensity * r0.w + 1);
  } else {
    r0.w = 1;
  }
  r0.w = v5.w * r0.w;
  r1.xyz = v5.xyz + -r0.xyz;
  r0.xyz = r0.www * r1.xyz + r0.xyz;
  o0.xyz = globalScalars3.zzz * r0.xyz;
  return;
}