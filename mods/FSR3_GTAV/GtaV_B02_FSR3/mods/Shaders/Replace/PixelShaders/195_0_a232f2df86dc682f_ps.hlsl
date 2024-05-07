// ---- FNV Hash a232f2df86dc682f

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

cbuffer ptfx_sprite_locals1 : register(b13)
{
  float wrapLigthtingTerm : packoffset(c0);
  float emissiveMultiplier : packoffset(c0.y);
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

cbuffer rage_SoftParticleBuffer : register(b5)
{
  float4 NearFarPlane : packoffset(c0);
  float4 gInvScreenSize : packoffset(c1);
}

cbuffer ptfx_sprite_locals2 : register(b8)
{
  float gBlendMode : packoffset(c0);
  float4 gChannelMask : packoffset(c1);
  float gSuperAlpha : packoffset(c2);
  float gDirectionalMult : packoffset(c2.y);
  float gAmbientMult : packoffset(c2.z);
  float gShadowAmount : packoffset(c2.w);
  float gExtraLightMult : packoffset(c3);
  float gCameraBias : packoffset(c3.y);
  float gCameraShrink : packoffset(c3.z);
  float gNormalArc : packoffset(c3.w);
  float gDirNormalBias : packoffset(c4);
  float gSoftnessCurve : packoffset(c4.y);
  float gSoftnessShadowMult : packoffset(c4.z);
  float gSoftnessShadowOffset : packoffset(c4.w);
  float gNormalMapMult : packoffset(c5);
  float3 gAlphaCutoffMinMax : packoffset(c5.y);
  float gRG_BlendStartDistance : packoffset(c6);
  float gRG_BlendEndDistance : packoffset(c6.y);
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

SamplerState FogRayTexSampler_s : register(s4);
SamplerState DiffuseTexSampler_s : register(s5);
SamplerState NormalSpecMapTexSampler_s : register(s7);
Texture2D<float4> FogRayTexSampler : register(t4);
Texture2D<float4> DiffuseTexSampler : register(t5);
Texture2D<float4> NormalSpecMapTexSampler : register(t7);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD0,
  float4 v1 : TEXCOORD1,
  float4 v2 : TEXCOORD2,
  nointerpolation float4 v3 : TEXCOORD3,
  float4 v4 : TEXCOORD5,
  float4 v5 : TEXCOORD6,
  float4 v6 : TEXCOORD7,
  float4 v7 : TEXCOORD8,
  float4 v8 : TEXCOORD9,
  float4 v9 : TEXCOORD10,
  float4 v10 : TEXCOORD11,
  float4 v11 : SV_Position0,
  float4 v12 : SV_ClipDistance0,
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
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = DiffuseTexSampler.Sample(DiffuseTexSampler_s, v1.xy).xyzw;
  r1.xyzw = DiffuseTexSampler.Sample(DiffuseTexSampler_s, v1.zw).xyzw;
  r2.x = r1.w + r0.w;
  r2.x = cmp(r2.x < 0.00499999989);
  if (r2.x != 0) discard;
  r0.xyz = r0.xyz * r0.xyz;
  r1.xyz = r1.xyz * r1.xyz;
  r1.xyzw = r1.xyzw + -r0.xyzw;
  r0.xyzw = v3.xxxx * r1.xyzw + r0.xyzw;
  r1.x = dot(v9.xyz, v9.xyz);
  r1.x = rsqrt(r1.x);
  r1.xyz = v9.xyz * r1.xxx;
  r1.w = dot(v10.xyzw, v10.xyzw);
  r1.w = rsqrt(r1.w);
  r2.xyz = v10.xyz * r1.www;
  r3.xyz = r2.zxy * r1.yzx;
  r3.xyz = r2.yzx * r1.zxy + -r3.xyz;
  r1.w = dot(r3.xyz, r3.xyz);
  r1.w = rsqrt(r1.w);
  r3.xyz = r3.xyz * r1.www;
  r4.xyzw = NormalSpecMapTexSampler.Sample(NormalSpecMapTexSampler_s, v2.xy).xyzw;
  r4.xy = r4.xy * float2(2,2) + float2(-1,-1);
  r1.w = dot(r4.xy, r4.xy);
  r1.w = 1 + -r1.w;
  r1.w = sqrt(abs(r1.w));
  r3.xyz = r4.yyy * r3.xyz;
  r2.xyz = r4.xxx * r2.xyz + r3.xyz;
  r1.xyz = r1.www * r1.xyz + r2.xyz;
  r0.xyzw = v0.xyzw * r0.xyzw;
  r2.xy = gAmbientMult * globalScalars.zy;
  r1.w = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r1.w = r2.y * r1.w;
  r2.y = saturate(v8.z * gCSMShaderVars_shared[3].x + gCSMShaderVars_shared[3].y);
  r2.y = sqrt(r2.y);
  r2.y = -r2.y * gCSMShaderVars_shared[3].z + 1;
  r2.y = gDirectionalMult * r2.y;
  r2.z = saturate(dot(r1.xyz, -gDirectionalLight.xyz));
  r2.z = wrapLigthtingTerm + r2.z;
  r2.w = 1 + wrapLigthtingTerm;
  r2.w = r2.w * r2.w;
  r2.z = saturate(r2.z / r2.w);
  r3.xyz = r2.zzz * r0.xyz;
  r3.xyz = gDirectionalColour.xyz * r3.xyz;
  r3.xyz = r3.xyz * r2.yyy;
  r2.y = cmp(0 >= gNumForwardLights);
  r2.z = cmp(gLightColourAndCapsuleExtent[0].w == 0.000000);
  r4.xyz = gLightPositionAndInvDistSqr[0].xyz + -v8.xyz;
  r5.xyz = -gLightPositionAndInvDistSqr[0].xyz + v8.xyz;
  r3.w = dot(r5.xyz, gLightDirectionAndFalloffExponent[0].xyz);
  r4.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[0].w;
  r3.w = saturate(r3.w / r4.w);
  r3.w = gLightColourAndCapsuleExtent[0].w * r3.w;
  r5.xyz = gLightDirectionAndFalloffExponent[0].xyz * r3.www + gLightPositionAndInvDistSqr[0].xyz;
  r5.xyz = -v8.xyz + r5.xyz;
  r4.xyz = r2.zzz ? r4.xyz : r5.xyz;
  r2.z = dot(r4.xyz, r4.xyz);
  r4.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r4.xyz;
  r3.w = dot(r4.xyz, r4.xyz);
  r3.w = rsqrt(r3.w);
  r4.xyz = r4.xyz * r3.www;
  r2.z = saturate(-r2.z * gLightPositionAndInvDistSqr[0].w + 1);
  r3.w = 1 + -gLightDirectionAndFalloffExponent[0].w;
  r3.w = r3.w * r2.z + gLightDirectionAndFalloffExponent[0].w;
  r2.z = r2.z / r3.w;
  r3.w = dot(r4.xyz, -gLightDirectionAndFalloffExponent[0].xyz);
  r3.w = saturate(r3.w * gLightConeScale[0] + gLightConeOffset[0]);
  r4.x = saturate(dot(r4.xyz, r1.xyz));
  r4.x = wrapLigthtingTerm + r4.x;
  r4.x = saturate(r4.x / r2.w);
  r3.w = r4.x * r3.w;
  r2.z = r3.w * r2.z;
  r4.xyz = gLightColourAndCapsuleExtent[0].xyz * r2.zzz;
  r4.xyz = r4.xyz * r0.xyz;
  r4.xyz = r2.yyy ? float3(0,0,0) : r4.xyz;
  r2.z = cmp(0 < gNumForwardLights);
  if (r2.z != 0) {
    r2.z = cmp(1 >= gNumForwardLights);
    r2.y = (int)r2.y | (int)r2.z;
    r2.z = cmp(gLightColourAndCapsuleExtent[1].w == 0.000000);
    r5.xyz = gLightPositionAndInvDistSqr[1].xyz + -v8.xyz;
    r6.xyz = -gLightPositionAndInvDistSqr[1].xyz + v8.xyz;
    r3.w = dot(r6.xyz, gLightDirectionAndFalloffExponent[1].xyz);
    r4.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[1].w;
    r3.w = saturate(r3.w / r4.w);
    r3.w = gLightColourAndCapsuleExtent[1].w * r3.w;
    r6.xyz = gLightDirectionAndFalloffExponent[1].xyz * r3.www + gLightPositionAndInvDistSqr[1].xyz;
    r6.xyz = -v8.xyz + r6.xyz;
    r5.xyz = r2.zzz ? r5.xyz : r6.xyz;
    r2.z = dot(r5.xyz, r5.xyz);
    r5.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r5.xyz;
    r3.w = dot(r5.xyz, r5.xyz);
    r3.w = rsqrt(r3.w);
    r5.xyz = r5.xyz * r3.www;
    r2.z = saturate(-r2.z * gLightPositionAndInvDistSqr[1].w + 1);
    r3.w = 1 + -gLightDirectionAndFalloffExponent[1].w;
    r3.w = r3.w * r2.z + gLightDirectionAndFalloffExponent[1].w;
    r2.z = r2.z / r3.w;
    r3.w = dot(r5.xyz, -gLightDirectionAndFalloffExponent[1].xyz);
    r3.w = saturate(r3.w * gLightConeScale[1] + gLightConeOffset[1]);
    r4.w = saturate(dot(r5.xyz, r1.xyz));
    r4.w = wrapLigthtingTerm + r4.w;
    r4.w = saturate(r4.w / r2.w);
    r3.w = r4.w * r3.w;
    r2.z = r3.w * r2.z;
    r5.xyz = gLightColourAndCapsuleExtent[1].xyz * r2.zzz;
    r5.xyz = r5.xyz * r0.xyz + r4.xyz;
    r4.xyz = r2.yyy ? r4.xyz : r5.xyz;
  } else {
    r2.y = -1;
  }
  if (r2.y == 0) {
    r2.z = cmp(2 >= gNumForwardLights);
    r2.y = (int)r2.y | (int)r2.z;
    r2.z = cmp(gLightColourAndCapsuleExtent[2].w == 0.000000);
    r5.xyz = gLightPositionAndInvDistSqr[2].xyz + -v8.xyz;
    r6.xyz = -gLightPositionAndInvDistSqr[2].xyz + v8.xyz;
    r3.w = dot(r6.xyz, gLightDirectionAndFalloffExponent[2].xyz);
    r4.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[2].w;
    r3.w = saturate(r3.w / r4.w);
    r3.w = gLightColourAndCapsuleExtent[2].w * r3.w;
    r6.xyz = gLightDirectionAndFalloffExponent[2].xyz * r3.www + gLightPositionAndInvDistSqr[2].xyz;
    r6.xyz = -v8.xyz + r6.xyz;
    r5.xyz = r2.zzz ? r5.xyz : r6.xyz;
    r2.z = dot(r5.xyz, r5.xyz);
    r5.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r5.xyz;
    r3.w = dot(r5.xyz, r5.xyz);
    r3.w = rsqrt(r3.w);
    r5.xyz = r5.xyz * r3.www;
    r2.z = saturate(-r2.z * gLightPositionAndInvDistSqr[2].w + 1);
    r3.w = 1 + -gLightDirectionAndFalloffExponent[2].w;
    r3.w = r3.w * r2.z + gLightDirectionAndFalloffExponent[2].w;
    r2.z = r2.z / r3.w;
    r3.w = dot(r5.xyz, -gLightDirectionAndFalloffExponent[2].xyz);
    r3.w = saturate(r3.w * gLightConeScale[2] + gLightConeOffset[2]);
    r4.w = saturate(dot(r5.xyz, r1.xyz));
    r4.w = wrapLigthtingTerm + r4.w;
    r4.w = saturate(r4.w / r2.w);
    r3.w = r4.w * r3.w;
    r2.z = r3.w * r2.z;
    r5.xyz = gLightColourAndCapsuleExtent[2].xyz * r2.zzz;
    r5.xyz = r5.xyz * r0.xyz + r4.xyz;
    r4.xyz = r2.yyy ? r4.xyz : r5.xyz;
  } else {
    r2.y = -1;
  }
  if (r2.y == 0) {
    r2.z = cmp(3 >= gNumForwardLights);
    r2.y = (int)r2.y | (int)r2.z;
    r2.z = cmp(gLightColourAndCapsuleExtent[3].w == 0.000000);
    r5.xyz = gLightPositionAndInvDistSqr[3].xyz + -v8.xyz;
    r6.xyz = -gLightPositionAndInvDistSqr[3].xyz + v8.xyz;
    r3.w = dot(r6.xyz, gLightDirectionAndFalloffExponent[3].xyz);
    r4.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[3].w;
    r3.w = saturate(r3.w / r4.w);
    r3.w = gLightColourAndCapsuleExtent[3].w * r3.w;
    r6.xyz = gLightDirectionAndFalloffExponent[3].xyz * r3.www + gLightPositionAndInvDistSqr[3].xyz;
    r6.xyz = -v8.xyz + r6.xyz;
    r5.xyz = r2.zzz ? r5.xyz : r6.xyz;
    r2.z = dot(r5.xyz, r5.xyz);
    r5.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r5.xyz;
    r3.w = dot(r5.xyz, r5.xyz);
    r3.w = rsqrt(r3.w);
    r5.xyz = r5.xyz * r3.www;
    r2.z = saturate(-r2.z * gLightPositionAndInvDistSqr[3].w + 1);
    r3.w = 1 + -gLightDirectionAndFalloffExponent[3].w;
    r3.w = r3.w * r2.z + gLightDirectionAndFalloffExponent[3].w;
    r2.z = r2.z / r3.w;
    r3.w = dot(r5.xyz, -gLightDirectionAndFalloffExponent[3].xyz);
    r3.w = saturate(r3.w * gLightConeScale[3] + gLightConeOffset[3]);
    r4.w = saturate(dot(r5.xyz, r1.xyz));
    r4.w = wrapLigthtingTerm + r4.w;
    r2.w = saturate(r4.w / r2.w);
    r2.w = r2.w * r3.w;
    r2.z = r2.w * r2.z;
    r5.xyz = gLightColourAndCapsuleExtent[3].xyz * r2.zzz;
    r5.xyz = r5.xyz * r0.xyz + r4.xyz;
    r4.xyz = r2.yyy ? r4.xyz : r5.xyz;
  }
  r2.y = gLightNaturalAmbient0.w + r1.z;
  r2.y = gLightNaturalAmbient1.w * r2.y;
  r2.y = max(0, r2.y);
  r5.xyz = gLightArtificialExtAmbient0.xyz * r2.yyy + gLightArtificialExtAmbient1.xyz;
  r2.z = 1 + -globalScalars2.z;
  r6.xyz = gLightArtificialIntAmbient0.xyz * r2.yyy + gLightArtificialIntAmbient1.xyz;
  r6.xyz = globalScalars2.zzz * r6.xyz;
  r5.xyz = r5.xyz * r2.zzz + r6.xyz;
  r5.xyz = r5.xyz * r1.www;
  r2.yzw = gLightNaturalAmbient0.xyz * r2.yyy + gLightNaturalAmbient1.xyz;
  r6.x = gLightArtificialIntAmbient1.w;
  r6.y = gLightArtificialExtAmbient0.w;
  r6.z = gLightArtificialExtAmbient1.w;
  r1.x = saturate(dot(r6.xyz, r1.xyz));
  r1.xyz = gDirectionalAmbientColour.xyz * r1.xxx + r2.yzw;
  r1.xyz = r1.xyz * r2.xxx + r5.xyz;
  r0.xyz = r1.xyz * r0.xyz;
  r0.xyz = r4.xyz * gExtraLightMult + r0.xyz;
  r0.xyz = r3.xyz * v7.zzz + r0.xyz;
  r1.x = cmp(0 < gGlobalFogIntensity);
  if (r1.x != 0) {
    r1.xy = gInvScreenSize.xy * v11.xy;
    r1.xyzw = FogRayTexSampler.Sample(FogRayTexSampler_s, r1.xy).xyzw;
    r1.x = -1 + r1.x;
    r1.x = saturate(gGlobalFogIntensity * r1.x + 1);
    r1.x = v4.w * r1.x;
  } else {
    r1.x = v4.w;
  }
  r0.w = saturate(r0.w);
  r1.yzw = v4.xyz + -r0.xyz;
  r0.xyz = r1.xxx * r1.yzw + r0.xyz;
  o0.xyz = globalScalars3.zzz * r0.xyz;
  r0.x = gGlobalParticleDofAlphaScale * r0.w;
  o0.w = r0.w;
  r0.y = v7.w;
  o1.x = r0.y;
  o2.x = r0.x;
  return;
}