
[Forma]
Clave=AgenteZona
Icono=115
Modulos=(Todos)
Nombre=<T>Zonas del Agente - <T> & Info.Agente
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=AgenteZona
CarpetaPrincipal=AgenteZona
ListaAcciones=Aceptar
Comentarios=Info.Nombre
PosicionInicialIzquierda=246
PosicionInicialArriba=274
PosicionInicialAlturaCliente=283
PosicionInicialAncho=307
EsMovimiento=S
MovModulo=TMA
MovimientosValidos=(Lista)
TituloAuto=S
MovEspecificos=Especificos
[AgenteZona]
Estilo=Hoja
Clave=AgenteZona
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AgenteZona
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=AgenteZona.Agente = <T>{Info.Agente}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
[AgenteZona.ListaEnCaptura]
(Inicio)=AgenteZona.Zona
AgenteZona.Zona=AgenteZona.Tipo
AgenteZona.Tipo=(Fin)

[AgenteZona.AgenteZona.Zona]
Carpeta=AgenteZona
Clave=AgenteZona.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[AgenteZona.AgenteZona.Tipo]
Carpeta=AgenteZona
Clave=AgenteZona.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

GuardarAntes=S
[AgenteZona.Columnas]
Zona=184
Tipo=84

















[Forma.MovimientosValidos]
(Inicio)=Acomodo
Acomodo=Reacomodo
Reacomodo=Surtido
Surtido=(Fin)
