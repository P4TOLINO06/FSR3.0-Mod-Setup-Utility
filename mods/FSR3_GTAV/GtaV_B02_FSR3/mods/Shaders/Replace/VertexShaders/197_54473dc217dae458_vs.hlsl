// ---- FNV Hash 54473dc217dae458

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:22:15 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer rage_clipplanes : register(b0)
{
  float4 ClipPlanes : packoffset(c0);
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

cbuffer ptfx_trail_locals2 : register(b8)
{
  float gAmbientMult : packoffset(c0);
  float gShadowAmount : packoffset(c0.y);
  float gDirectionalMult : packoffset(c0.z);
  float gExtraLightMult : packoffset(c0.w);
  float gSoftnessCurve : packoffset(c1);
  float gSoftnessShadowMult : packoffset(c1.y);
  float gSoftnessShadowOffset : packoffset(c1.z);
}

SamplerComparisonState gCSMShadowTextureSamp_s : register(s15);
Texture2D<float4> gCSMShadowTexture : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD0,
  float3 v3 : TEXCOORD1,
  uint v4 : SV_InstanceID0,
  out float4 o0 : TEXCOORD0,
  out float4 o1 : TEXCOORD1,
  out float4 o2 : TEXCOORD2,
  out float4 o3 : SV_Position0,
  out float4 o4 : SV_ClipDistance0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xyz
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[4];
  r0.xyzw = gWorldViewProj._m10_m11_m12_m13 * v0.yyyy;
  r0.xyzw = v0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r0.xyzw;
  r0.xyzw = v0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r0.xyzw;
  r0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  r1.xyz = -gViewInverse._m30_m31_m32 + v0.xyz;
  r1.w = dot(r1.xyz, r1.xyz);
  r2.x = sqrt(r1.w);
  r2.y = -globalFogParams[0].x + r2.x;
  r2.y = max(0, r2.y);
  r2.x = r2.y / r2.x;
  r2.x = r2.x * r1.z;
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
  r3.xyz = r1.xyz * r1.www;
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
  o2.w = saturate(r2.x * r3.x + r2.z);
  r2.y = -globalFogParams[1].z * r2.y;
  r2.y = 1.44269502 * r2.y;
  r2.y = exp2(r2.y);
  r2.y = 1 + -r2.y;
  r3.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
  r3.xyz = r1.www * r3.xyz + globalFogColorE.xyz;
  r4.xyz = globalFogColor.xyz + -r3.xyz;
  r3.xyz = r2.www * r4.xyz + r3.xyz;
  r3.xyz = -globalFogColorN.xyz + r3.xyz;
  r2.yzw = r2.yyy * r3.xyz + globalFogColorN.xyz;
  r3.x = globalFogColor.w + -r2.y;
  r3.y = globalFogColorE.w + -r2.z;
  r3.z = globalFogColorN.w + -r2.w;
  o2.xyz = r2.xxx * r3.xyz + r2.yzw;
  r1.w = dot(v3.xyz, v3.xyz);
  r1.w = rsqrt(r1.w);
  r2.xyz = v3.yzx * r1.www;
  r1.w = v2.y * 2 + -1;
  r3.xyz = -gViewInverse._m22_m20_m21 * r2.xyz;
  r2.xyz = -gViewInverse._m21_m22_m20 * r2.yzx + -r3.xyz;
  r2.w = 1 + -abs(r1.w);
  r3.xyz = gViewInverse._m20_m21_m22 * r2.www;
  r2.xyz = r2.xyz * r1.www + r3.xyz;
  r1.w = dot(r2.xyz, r2.xyz);
  r1.w = rsqrt(r1.w);
  r2.xyw = r2.xyz * r1.www;
  r3.xyz = v1.xyz * v1.xyz;
  r4.xy = gAmbientMult * globalScalars.zy;
  r5.xyz = gCSMShaderVars_shared[1].xyz * r1.yyy;
  r5.xyz = r1.xxx * gCSMShaderVars_shared[0].xyz + r5.xyz;
  r1.xyz = r1.zzz * gCSMShaderVars_shared[2].xyz + r5.xyz;
  r5.xyz = r1.xyz * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
  x0[0].xyz = r5.xyz;
  r6.xyz = r1.xyz * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
  x0[1].xyz = r6.xyz;
  r7.xyz = r1.xyz * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
  x0[2].xyz = r7.xyz;
  r1.xyz = r1.xyz * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
  x0[3].xyz = r1.xyz;
  r1.x = -gCSMResolution.z * 1.5 + 1;
  r1.x = 0.5 * r1.x;
  r1.y = max(abs(r7.x), abs(r7.y));
  r1.y = cmp(r1.y < r1.x);
  r1.y = r1.y ? 2 : 3;
  r1.z = max(abs(r6.x), abs(r6.y));
  r1.z = cmp(r1.z < r1.x);
  r1.y = r1.z ? 1 : r1.y;
  r1.z = max(abs(r5.x), abs(r5.y));
  r1.x = cmp(r1.z < r1.x);
  r1.x = r1.x ? 0 : r1.y;
  r5.xyz = x0[r1.x+0].xyz;
  r1.x = (int)r1.x;
  r1.x = 0.5 + r1.x;
  r1.x = 0.25 * r1.x;
  r6.x = 0.5 + r5.x;
  r6.y = r5.y * 0.25 + r1.x;
  r1.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r6.xy, r5.z).x;
  r1.y = saturate(v0.z * gCSMShaderVars_shared[3].x + gCSMShaderVars_shared[3].y);
  r1.y = sqrt(r1.y);
  r1.y = -r1.y * gCSMShaderVars_shared[3].z + 1;
  r1.y = gDirectionalMult * r1.y;
  r1.z = saturate(dot(r2.xyw, -gDirectionalLight.xyz));
  r5.xyz = r3.xyz * r1.zzz;
  r5.xyz = gDirectionalColour.xyz * r5.xyz;
  r5.xyz = r5.xyz * r1.yyy;
  r1.y = cmp(0 >= gNumForwardLights);
  r1.z = cmp(gLightColourAndCapsuleExtent[0].w == 0.000000);
  r6.xyz = gLightPositionAndInvDistSqr[0].xyz + -v0.xyz;
  r7.xyz = -gLightPositionAndInvDistSqr[0].xyz + v0.xyz;
  r3.w = dot(r7.xyz, gLightDirectionAndFalloffExponent[0].xyz);
  r4.z = 9.99999975e-05 + gLightColourAndCapsuleExtent[0].w;
  r3.w = saturate(r3.w / r4.z);
  r3.w = gLightColourAndCapsuleExtent[0].w * r3.w;
  r7.xyz = gLightDirectionAndFalloffExponent[0].xyz * r3.www + gLightPositionAndInvDistSqr[0].xyz;
  r7.xyz = -v0.xyz + r7.xyz;
  r6.xyz = r1.zzz ? r6.xyz : r7.xyz;
  r1.z = dot(r6.xyz, r6.xyz);
  r6.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r6.xyz;
  r3.w = dot(r6.xyz, r6.xyz);
  r3.w = rsqrt(r3.w);
  r6.xyz = r6.xyz * r3.www;
  r1.z = saturate(-r1.z * gLightPositionAndInvDistSqr[0].w + 1);
  r3.w = 1 + -gLightDirectionAndFalloffExponent[0].w;
  r3.w = r3.w * r1.z + gLightDirectionAndFalloffExponent[0].w;
  r1.z = r1.z / r3.w;
  r3.w = dot(r6.xyz, -gLightDirectionAndFalloffExponent[0].xyz);
  r3.w = saturate(r3.w * gLightConeScale[0] + gLightConeOffset[0]);
  r4.z = saturate(dot(r6.xyz, r2.xyw));
  r3.w = r4.z * r3.w;
  r1.z = r3.w * r1.z;
  r6.xyz = gLightColourAndCapsuleExtent[0].xyz * r1.zzz;
  r6.xyz = r6.xyz * r3.xyz;
  r6.xyz = r1.yyy ? float3(0,0,0) : r6.xyz;
  r1.z = cmp(0 < gNumForwardLights);
  if (r1.z != 0) {
    r1.z = cmp(1 >= gNumForwardLights);
    r1.y = (int)r1.y | (int)r1.z;
    r1.z = cmp(gLightColourAndCapsuleExtent[1].w == 0.000000);
    r7.xyz = gLightPositionAndInvDistSqr[1].xyz + -v0.xyz;
    r8.xyz = -gLightPositionAndInvDistSqr[1].xyz + v0.xyz;
    r3.w = dot(r8.xyz, gLightDirectionAndFalloffExponent[1].xyz);
    r4.z = 9.99999975e-05 + gLightColourAndCapsuleExtent[1].w;
    r3.w = saturate(r3.w / r4.z);
    r3.w = gLightColourAndCapsuleExtent[1].w * r3.w;
    r8.xyz = gLightDirectionAndFalloffExponent[1].xyz * r3.www + gLightPositionAndInvDistSqr[1].xyz;
    r8.xyz = -v0.xyz + r8.xyz;
    r7.xyz = r1.zzz ? r7.xyz : r8.xyz;
    r1.z = dot(r7.xyz, r7.xyz);
    r7.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r7.xyz;
    r3.w = dot(r7.xyz, r7.xyz);
    r3.w = rsqrt(r3.w);
    r7.xyz = r7.xyz * r3.www;
    r1.z = saturate(-r1.z * gLightPositionAndInvDistSqr[1].w + 1);
    r3.w = 1 + -gLightDirectionAndFalloffExponent[1].w;
    r3.w = r3.w * r1.z + gLightDirectionAndFalloffExponent[1].w;
    r1.z = r1.z / r3.w;
    r3.w = dot(r7.xyz, -gLightDirectionAndFalloffExponent[1].xyz);
    r3.w = saturate(r3.w * gLightConeScale[1] + gLightConeOffset[1]);
    r4.z = saturate(dot(r7.xyz, r2.xyw));
    r3.w = r4.z * r3.w;
    r1.z = r3.w * r1.z;
    r7.xyz = gLightColourAndCapsuleExtent[1].xyz * r1.zzz;
    r7.xyz = r7.xyz * r3.xyz + r6.xyz;
    r6.xyz = r1.yyy ? r6.xyz : r7.xyz;
  } else {
    r1.y = -1;
  }
  if (r1.y == 0) {
    r1.z = cmp(2 >= gNumForwardLights);
    r1.y = (int)r1.y | (int)r1.z;
    r1.z = cmp(gLightColourAndCapsuleExtent[2].w == 0.000000);
    r7.xyz = gLightPositionAndInvDistSqr[2].xyz + -v0.xyz;
    r8.xyz = -gLightPositionAndInvDistSqr[2].xyz + v0.xyz;
    r3.w = dot(r8.xyz, gLightDirectionAndFalloffExponent[2].xyz);
    r4.z = 9.99999975e-05 + gLightColourAndCapsuleExtent[2].w;
    r3.w = saturate(r3.w / r4.z);
    r3.w = gLightColourAndCapsuleExtent[2].w * r3.w;
    r8.xyz = gLightDirectionAndFalloffExponent[2].xyz * r3.www + gLightPositionAndInvDistSqr[2].xyz;
    r8.xyz = -v0.xyz + r8.xyz;
    r7.xyz = r1.zzz ? r7.xyz : r8.xyz;
    r1.z = dot(r7.xyz, r7.xyz);
    r7.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r7.xyz;
    r3.w = dot(r7.xyz, r7.xyz);
    r3.w = rsqrt(r3.w);
    r7.xyz = r7.xyz * r3.www;
    r1.z = saturate(-r1.z * gLightPositionAndInvDistSqr[2].w + 1);
    r3.w = 1 + -gLightDirectionAndFalloffExponent[2].w;
    r3.w = r3.w * r1.z + gLightDirectionAndFalloffExponent[2].w;
    r1.z = r1.z / r3.w;
    r3.w = dot(r7.xyz, -gLightDirectionAndFalloffExponent[2].xyz);
    r3.w = saturate(r3.w * gLightConeScale[2] + gLightConeOffset[2]);
    r4.z = saturate(dot(r7.xyz, r2.xyw));
    r3.w = r4.z * r3.w;
    r1.z = r3.w * r1.z;
    r7.xyz = gLightColourAndCapsuleExtent[2].xyz * r1.zzz;
    r7.xyz = r7.xyz * r3.xyz + r6.xyz;
    r6.xyz = r1.yyy ? r6.xyz : r7.xyz;
  } else {
    r1.y = -1;
  }
  if (r1.y == 0) {
    r1.z = cmp(3 >= gNumForwardLights);
    r1.y = (int)r1.y | (int)r1.z;
    r1.z = cmp(gLightColourAndCapsuleExtent[3].w == 0.000000);
    r7.xyz = gLightPositionAndInvDistSqr[3].xyz + -v0.xyz;
    r8.xyz = -gLightPositionAndInvDistSqr[3].xyz + v0.xyz;
    r3.w = dot(r8.xyz, gLightDirectionAndFalloffExponent[3].xyz);
    r4.z = 9.99999975e-05 + gLightColourAndCapsuleExtent[3].w;
    r3.w = saturate(r3.w / r4.z);
    r3.w = gLightColourAndCapsuleExtent[3].w * r3.w;
    r8.xyz = gLightDirectionAndFalloffExponent[3].xyz * r3.www + gLightPositionAndInvDistSqr[3].xyz;
    r8.xyz = -v0.xyz + r8.xyz;
    r7.xyz = r1.zzz ? r7.xyz : r8.xyz;
    r1.z = dot(r7.xyz, r7.xyz);
    r7.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r7.xyz;
    r3.w = dot(r7.xyz, r7.xyz);
    r3.w = rsqrt(r3.w);
    r7.xyz = r7.xyz * r3.www;
    r1.z = saturate(-r1.z * gLightPositionAndInvDistSqr[3].w + 1);
    r3.w = 1 + -gLightDirectionAndFalloffExponent[3].w;
    r3.w = r3.w * r1.z + gLightDirectionAndFalloffExponent[3].w;
    r1.z = r1.z / r3.w;
    r3.w = dot(r7.xyz, -gLightDirectionAndFalloffExponent[3].xyz);
    r3.w = saturate(r3.w * gLightConeScale[3] + gLightConeOffset[3]);
    r4.z = saturate(dot(r7.xyz, r2.xyw));
    r3.w = r4.z * r3.w;
    r1.z = r3.w * r1.z;
    r7.xyz = gLightColourAndCapsuleExtent[3].xyz * r1.zzz;
    r7.xyz = r7.xyz * r3.xyz + r6.xyz;
    r6.xyz = r1.yyy ? r6.xyz : r7.xyz;
  }
  r1.y = r2.z * r1.w + gLightNaturalAmbient0.w;
  r1.y = gLightNaturalAmbient1.w * r1.y;
  r1.y = max(0, r1.y);
  r7.xyz = gLightArtificialExtAmbient0.xyz * r1.yyy + gLightArtificialExtAmbient1.xyz;
  r1.z = 1 + -globalScalars2.z;
  r8.xyz = gLightArtificialIntAmbient0.xyz * r1.yyy + gLightArtificialIntAmbient1.xyz;
  r8.xyz = globalScalars2.zzz * r8.xyz;
  r7.xyz = r7.xyz * r1.zzz + r8.xyz;
  r4.yzw = r7.xyz * r4.yyy;
  r1.yzw = gLightNaturalAmbient0.xyz * r1.yyy + gLightNaturalAmbient1.xyz;
  r7.x = gLightArtificialIntAmbient1.w;
  r7.y = gLightArtificialExtAmbient0.w;
  r7.z = gLightArtificialExtAmbient1.w;
  r2.x = saturate(dot(r7.xyz, r2.xyw));
  r1.yzw = gDirectionalAmbientColour.xyz * r2.xxx + r1.yzw;
  r1.yzw = r1.yzw * r4.xxx + r4.yzw;
  r1.yzw = r1.yzw * r3.xyz;
  r1.yzw = r6.xyz * gExtraLightMult + r1.yzw;
  o0.xyz = r5.xyz * r1.xxx + r1.yzw;
  o4.x = dot(r0.xyzw, ClipPlanes.xyzw);
  o0.w = v1.w;
  o1.xy = v2.xy;
  o1.z = r0.w;
  o1.w = 0;
  o3.xyzw = r0.xyzw;
  o4.yzw = float3(0,0,0);
  return;
}