[Forma]
Clave=OportunidadPlantillaGrupo
Nombre=Oportunidad Grupos Plantillas
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
PosicionInicialIzquierda=553
PosicionInicialArriba=208
PosicionInicialAltura=300
PosicionInicialAncho=290
PosicionInicialAlturaCliente=298

MovModulo=OPORT
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadPlantillaGrupo
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=OportunidadPlantillaGrupo.Grupo
CarpetaVisible=S

[Lista.OportunidadPlantillaGrupo.Grupo]
Carpeta=Lista
Clave=OportunidadPlantillaGrupo.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
Activo=S
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(OportunidadPlantillaGrupo:OportunidadPlantillaGrupo.Grupo)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Lista.Columnas]
Grupo=231

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel
Visible=S

[Acciones.Anexos]
Nombre=Anexos
Boton=77
NombreDesplegar=Anexos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(OportunidadPlantillaGrupo:OportunidadPlantillaGrupo.Grupo)
AntesExpresiones=Asigna(Info.Rama, <T>CGRP<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, OportunidadPlantillaGrupo:OportunidadPlantillaGrupo.Grupo)<BR>Asigna(Info.Descripcion, OportunidadPlantillaGrupo:OportunidadPlantillaGrupo.Grupo)
RefrescarDespues=S









[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=Anexos
Anexos=(Fin)
