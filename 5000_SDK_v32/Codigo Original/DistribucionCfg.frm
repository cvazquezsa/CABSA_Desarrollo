[Forma]
Clave=DistribucionCfg
Icono=0
Modulos=(Todos)
Nombre=<T>Distribución <T> & DistribucionCfg:DistribucionCfg.Empresa
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Guardar
PosicionInicialIzquierda=539
PosicionInicialArriba=268
PosicionInicialAlturaCliente=153
PosicionInicialAncho=288
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
VentanaEscCerrar=S

[Lista]
Estilo=Ficha
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=133
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Vista=DistribucionCfg
ListaEnCaptura=(Lista)

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=Empresa = {Comillas(Info.Empresa)}
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[Lista.DistribucionCfg.Estatus]
Carpeta=Lista
Clave=DistribucionCfg.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.DistribucionCfg.Consecutivo]
Carpeta=Lista
Clave=DistribucionCfg.Consecutivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
[Lista.DistribucionCfg.Reservar]
Carpeta=Lista
Clave=DistribucionCfg.Reservar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



EspacioPrevio=N


































[Lista.ListaEnCaptura]
(Inicio)=DistribucionCfg.Empresa
DistribucionCfg.Empresa=DistribucionCfg.Estatus
DistribucionCfg.Estatus=DistribucionCfg.Consecutivo
DistribucionCfg.Consecutivo=DistribucionCfg.Reservar
DistribucionCfg.Reservar=(Fin)

[Lista.DistribucionCfg.Empresa]
Carpeta=Lista
Clave=DistribucionCfg.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
