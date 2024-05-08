// ---- FNV Hash 2c2e35b59b7ed6fd

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:49 2023

struct InstanceBuffer_type
{
    uint InstId_u16_CrossFade_Scale_u8;// Offset:    0
};

struct RawInstanceBuffer_type
{
    uint PosXY_u16;                // Offset:    0
    uint PosZ_u16_NormXY_u8;       // Offset:    4
    uint ColorRGB_Scale_u8;        // Offset:    8
    uint Ao_Pad3_u8;               // Offset:   12
};

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

cbuffer megashader_locals : register(b12)
{
  float specularFresnel : packoffset(c0);
  float specularFalloffMult : packoffset(c0.y);
  float specularIntensityMult : packoffset(c0.z);
  float3 specMapIntMask : packoffset(c1);
  float bumpiness : packoffset(c1.w);
  float wetnessMultiplier : packoffset(c2);
  float useTessellation : packoffset(c2.y);
  float HardAlphaBlend : packoffset(c2.z);
  float3 vecBatchAabbMin : packoffset(c3);
  float3 vecBatchAabbDelta : packoffset(c4);
  float gOrientToTerrain : packoffset(c4.w);
  float3 gScaleRange : packoffset(c5);
  float3 gLodFadeInstRange : packoffset(c6);
  uint gUseComputeShaderOutputBuffer : packoffset(c6.w);
  float2 gInstCullParams : packoffset(c7);
  uint gNumClipPlanes : packoffset(c7.z);
  float4 gClipPlanes[16] : packoffset(c8);
  float3 gCameraPosition : packoffset(c24);
  uint gLodInstantTransition : packoffset(c24.w);
  float4 gLodThresholds : packoffset(c25);
  float2 gCrossFadeDistance : packoffset(c26);
  uint gIsShadowPass : packoffset(c26.z);
  float3 gLodFadeControlRange : packoffset(c27);
  float2 gLodFadeStartDist : packoffset(c28);
  float2 gLodFadeRange : packoffset(c28.z);
  float2 gLodFadePower : packoffset(c29);
  float2 gLodFadeTileScale : packoffset(c29.z);
}

cbuffer grassbatch_instmtx : register(b7)
{
  float4 gInstanceVars[24] : packoffset(c0);
}

StructuredBuffer<InstanceBuffer_type> InstanceBuffer : register(t0);
StructuredBuffer<RawInstanceBuffer_type> RawInstanceBuffer : register(t1);


// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : COLOR1,
  float2 v3 : TEXCOORD0,
  float3 v4 : NORMAL0,
  float4 v5 : TANGENT0,
  uint v6 : SV_InstanceID0,
  out float4 o0 : SV_Position0,
  out float4 o1 : COLOR0,
  out float3 o2 : COLOR1,
  out float4 o3 : TEXCOORD1,
  out float4 o4 : TEXCOORD4,
  out float3 o5 : TEXCOORD5,
  out float4 o6 : COLOR2,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.x
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v6.x, instance_id
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = InstanceBuffer[v6.x].InstId_u16_CrossFade_Scale_u8;
  r0.y = (uint)r0.x >> 16;
  r0.y = (int)r0.y & 255;
  r0.y = (uint)r0.y;
  r1.y = 0.00392156886 * r0.y;
  r2.x = v6.x;
  r2.yz = float2(1,1);
  r0.y = (uint)r0.x >> 24;
  r1.x = (int)r0.x & 0x0000ffff;
  r0.x = (uint)r0.y;
  r1.z = 0.00392156886 * r0.x;
  r0.xyz = gUseComputeShaderOutputBuffer ? r1.xyz : r2.xyz;
  r1.x = RawInstanceBuffer[r0.x].PosXY_u16;
  r1.y = RawInstanceBuffer[r0.x].PosZ_u16_NormXY_u8;
  r1.z = RawInstanceBuffer[r0.x].ColorRGB_Scale_u8;
  r1.w = RawInstanceBuffer[r0.x].Ao_Pad3_u8;
  r2.w = (uint)r1.z >> 8;
  r2.xy = (uint2)r1.xy >> 16;
  r2.yz = (int2)r2.yw & int2(255,255);
  r3.y = (uint)r2.x;
  r2.x = (uint)r2.y;
  r4.y = (uint)r2.z;
  r0.w = (uint)r1.y >> 24;
  r2.y = (uint)r0.w;
  r2.xy = r2.xy * float2(0.00784313772,0.00784313772) + float2(-1,-1);
  r0.w = dot(r2.xy, r2.xy);
  r0.w = 1 + -r0.w;
  r2.z = sqrt(r0.w);
  r0.w = r2.z * -0.0187292993 + 0.0742610022;
  r0.w = r0.w * r2.z + -0.212114394;
  r0.w = r0.w * r2.z + 1.57072878;
  r2.w = 1 + -r2.z;
  r2.xyz = -r2.zzz * float3(0,0,1) + r2.xyz;
  r2.w = sqrt(r2.w);
  r0.w = r2.w * r0.w;
  r0.w = gOrientToTerrain * r0.w;
  sincos(r0.w, r5.x, r6.x);
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r2.xyz = r2.xyz * r5.xxx;
  r2.xyz = r6.xxx * float3(0,0,1) + r2.xyz;
  r0.w = 1 + -r2.z;
  r5.xy = float2(1,0) * r2.yz;
  r5.yw = r2.zx * float2(0,1) + -r5.xy;
  r2.w = dot(r5.yw, r5.yw);
  r2.w = sqrt(r2.w);
  r6.xy = r5.yw / r2.ww;
  r2.w = r6.y * r6.y;
  r7.x = r2.w * r0.w + r2.z;
  r0.w = r6.x * r0.w;
  r7.z = -r5.y;
  r5.z = r0.w * r6.y;
  r5.x = r0.w * r6.x + r2.z;
  r7.w = r5.z;
  r0.w = cmp(r2.z < 1);
  r2.xyz = float3(-1,-1,1) * r2.xyz;
  r2.xyz = r0.www ? r2.xyz : float3(0,0,1);
  r6.xyz = r0.www ? r7.wxz : float3(0,1,0);
  r5.xyz = r0.www ? r5.xzw : float3(1,0,0);
  r0.x = (int)r0.x & 7;
  r0.x = (int)r0.x * 3;
  r7.y = dot(gInstanceVars[r0.x].xyz, r6.xyz);
  r7.x = dot(gInstanceVars[r0.x].xyz, r5.xyz);
  r7.z = dot(gInstanceVars[r0.x].xyz, r2.xyz);
  r0.w = (uint)r1.z >> 24;
  r0.w = (uint)r0.w;
  r0.w = 0.00392156886 * r0.w;
  r2.w = gScaleRange.y + -gScaleRange.x;
  r0.w = r2.w * r0.w + gScaleRange.x;
  r2.w = gScaleRange.y * gScaleRange.z;
  r2.w = dot(gInstanceVars[r0.x].ww, r2.ww);
  r2.w = -gScaleRange.y * gScaleRange.z + r2.w;
  r0.w = r2.w + r0.w;
  r0.w = max(0, r0.w);
  r0.yw = r0.yw * r0.zz;
  o1.w = v1.w * r0.y;
  r7.xyz = r7.xyz * r0.www;
  r8.x = r7.y;
  r9.y = dot(gInstanceVars[r0.x+1].xyz, r6.xyz);
  r6.y = dot(gInstanceVars[r0.x+2].xyz, r6.xyz);
  r9.x = dot(gInstanceVars[r0.x+1].xyz, r5.xyz);
  r6.x = dot(gInstanceVars[r0.x+2].xyz, r5.xyz);
  r9.z = dot(gInstanceVars[r0.x+1].xyz, r2.xyz);
  r6.z = dot(gInstanceVars[r0.x+2].xyz, r2.xyz);
  r0.xyz = r6.xyz * r0.www;
  r2.xyz = r9.xyz * r0.www;
  r8.y = r2.y;
  r8.z = r0.y;
  r5.xyzw = (int4)r1.xyzw & int4(0xffff,0xffff,255,255);
  r0.w = (uint)r1.z >> 16;
  r0.w = (int)r0.w & 255;
  r4.z = (uint)r0.w;
  r3.xzw = (uint3)r5.xyw;
  r4.x = (uint)r5.z;
  o6.xyz = float3(0.00392156886,0.00392156886,0.00392156886) * r4.xyz;
  r1.xyz = vecBatchAabbDelta.xyz * r3.xyz;
  o2.z = 0.00392156886 * r3.w;
  r1.xyz = r1.xyz * float3(1.52590219e-05,1.52590219e-05,1.52590219e-05) + vecBatchAabbMin.xyz;
  r8.w = r1.y;
  r3.xyz = v0.xyz;
  r3.w = 1;
  r0.w = dot(r3.xyzw, r8.xyzw);
  r4.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.wwww;
  r5.x = r7.x;
  r5.y = r2.x;
  r5.z = r0.x;
  r5.w = r1.x;
  r0.w = dot(r3.xyzw, r5.xyzw);
  r4.xyzw = r0.wwww * gWorldViewProj._m00_m01_m02_m03 + r4.xyzw;
  r5.x = r7.z;
  r5.y = r2.z;
  r5.z = r0.z;
  r5.w = r1.z;
  r0.w = dot(r3.xyzw, r5.xyzw);
  r3.xyzw = r0.wwww * gWorldViewProj._m20_m21_m22_m23 + r4.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r3.xyzw;
  r3.xyz = v0.yyy * r2.xyz;
  r3.xyz = v0.xxx * r7.xyz + r3.xyz;
  r3.xyz = v0.zzz * r0.xyz + r3.xyz;
  r1.xyz = r3.xyz + r1.xyz;
  r1.xyz = gViewInverse._m30_m31_m32 + -r1.xyz;
  r0.w = dot(r1.xyz, r1.xyz);
  r0.w = 3.99999999e-06 * r0.w;
  r1.x = min(1, r0.w);
  r1.y = 1 + -r1.x;
  r1.xy = saturate(-globalScalars2.zz + r1.xy);
  r0.w = -1 + gDirectionalAmbientColour.w;
  r1.xy = r1.xy * r0.ww + float2(1,1);
  o1.xy = saturate(v1.xy * r1.xy);
  o1.z = v1.z;
  o2.xy = v3.xy;
  r0.w = dot(v4.xyz, v4.xyz);
  r0.w = cmp(r0.w < 0.100000001);
  r1.xyz = r0.www ? float3(0,0,1) : v4.xyz;
  r3.xyz = r1.yyy * r2.xyz;
  r2.xyz = v5.yyy * r2.xyz;
  r2.xyz = v5.xxx * r7.xyz + r2.xyz;
  r1.xyw = r1.xxx * r7.xyz + r3.xyz;
  r1.xyz = r1.zzz * r0.xyz + r1.xyw;
  r0.xyz = v5.zzz * r0.xyz + r2.xyz;
  r0.w = dot(r1.xyz, r1.xyz);
  r0.w = rsqrt(r0.w);
  r1.xyz = r1.xyz * r0.www;
  o3.xyz = r1.xyz;
  o4.xyz = r0.xyz;
  r2.xyz = r1.yzx * r0.zxy;
  r0.xyz = r0.yzx * r1.zxy + -r2.xyz;
  o5.xyz = v5.www * r0.xyz;
  o6.w = v2.x;
  return;
}