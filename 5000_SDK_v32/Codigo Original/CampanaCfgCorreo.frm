[Forma]
Clave=CampanaCfgCorreo
Nombre=Configuración - Correos Automáticos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=487
PosicionInicialArriba=340
PosicionInicialAlturaCliente=484
PosicionInicialAncho=871
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Mov, Info.MovID, Info.Tipo)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaCfgCorreo
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
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
HojaAjustarColumnas=S
FiltroGeneral=CampanaCfgCorreo.ID={Info.ID}

[Lista.CampanaCfgCorreo.Frecuencia]
Carpeta=Lista
Clave=CampanaCfgCorreo.Frecuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaCfgCorreo.SiguienteEnvio]
Carpeta=Lista
Clave=CampanaCfgCorreo.SiguienteEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaCfgCorreo.Pagina]
Carpeta=Lista
Clave=CampanaCfgCorreo.Pagina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaCfgCorreo.Asunto]
Carpeta=Lista
Clave=CampanaCfgCorreo.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Frecuencia=124
SiguienteEnvio=83
SituacionEsp=133
Pagina=74
Asunto=409
Estatus=72
Situacion=140

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

[Lista.CampanaCfgCorreo.Situacion]
Carpeta=Lista
Clave=CampanaCfgCorreo.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=CampanaCfgCorreo.Frecuencia
CampanaCfgCorreo.Frecuencia=CampanaCfgCorreo.SiguienteEnvio
CampanaCfgCorreo.SiguienteEnvio=CampanaCfgCorreo.Situacion
CampanaCfgCorreo.Situacion=CampanaCfgCorreo.Pagina
CampanaCfgCorreo.Pagina=CampanaCfgCorreo.Asunto
CampanaCfgCorreo.Asunto=(Fin)
