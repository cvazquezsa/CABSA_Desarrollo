[Forma]
Clave=CfgECollaborationMov
Nombre=e-Collaboration - Mapa Movimientos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=424
PosicionInicialArriba=201
PosicionInicialAlturaCliente=288
PosicionInicialAncho=517
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgECollaborationMov
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaColorFondo=Plata
[Lista.CfgECollaborationMov.Modulo]
Carpeta=Lista
Clave=CfgECollaborationMov.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.CfgECollaborationMov.Mov]
Carpeta=Lista
Clave=CfgECollaborationMov.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CfgECollaborationMov.ModuloDestino]
Carpeta=Lista
Clave=CfgECollaborationMov.ModuloDestino
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.CfgECollaborationMov.MovDestino]
Carpeta=Lista
Clave=CfgECollaborationMov.MovDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Modulo=78
Mov=169
ModuloDestino=84
MovDestino=141


0=-2
1=-2
2=-2
3=-2
[Acciones.Mapeo]
Nombre=Mapeo
Boton=108
NombreEnBoton=S
NombreDesplegar=Mapeo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=eCollaborationProvCte
Activo=S
Visible=S





Antes=S






GuardarAntes=S
DespuesGuardar=S















AntesExpresiones=Asigna(Info.Modulo, CfgECollaborationMov:CfgECollaborationMov.Modulo)<BR>Asigna(Info.Mov, CfgECollaborationMov:CfgECollaborationMov.Mov)<BR>Asigna(Temp.TextoTemp01, <T>Proveedor (Movimiento Destino)<T>)<BR>Asigna(Temp.TextoTemp02, <T>Cliente (Movimiento Origen)<T>)<BR>Si(Info.Modulo = <T>COMS<T>,Asigna(Temp.TextoTemp01, <T>Proveedor (Movimiento Origen)<T>) )<BR>Si(Info.Modulo = <T>COMS<T>,Asigna(Temp.TextoTemp02, <T>Cliente (Movimiento Destino)<T>) )<BR>Si(Info.Modulo = <T>CXP<T>,Asigna(Temp.TextoTemp01, <T>Proveedor (Movimiento Origen)<T>) )<BR>Si(Info.Modulo = <T>CXP<T>,Asigna(Temp.TextoTemp02, <T>Cliente (Movimiento Destino)<T>) )
[Lista.ListaEnCaptura]
(Inicio)=CfgECollaborationMov.Modulo
CfgECollaborationMov.Modulo=CfgECollaborationMov.Mov
CfgECollaborationMov.Mov=CfgECollaborationMov.ModuloDestino
CfgECollaborationMov.ModuloDestino=CfgECollaborationMov.MovDestino
CfgECollaborationMov.MovDestino=(Fin)













































































































































































































































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Mapeo
Mapeo=(Fin)
