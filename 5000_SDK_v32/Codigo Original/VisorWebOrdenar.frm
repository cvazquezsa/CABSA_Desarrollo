[Forma]
Clave=VisorWebOrdenar
Icono=48
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
Nombre=Ordenar Visor Web
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=444
PosicionInicialArriba=179
PosicionInicialAlturaCliente=488
PosicionInicialAncho=715
Comentarios=Lista(<T>Utilice arrastrar y soltar para cambiar el orden<T>,Info.Categoria)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VisorWebConfigD
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Registros
OtroOrden=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
IconosSubTitulo=<T>Orden<T>
IconosCambiarOrden=S
ListaOrden=VisorWebConfigD.Orden<TAB>(Acendente)


Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaEnCaptura=(Lista)
IconosNombre=VisorWebConfigD:VisorWebConfigD.Orden
FiltroGeneral=VisorWebConfigD.Formato=<T>{Info.Categoria}<T>
[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Ordenar]
Nombre=Ordenar
Boton=3
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Antes=S
Visible=S
NombreDesplegar=&Guardar Nuevo Orden
NombreEnBoton=S

AntesExpresiones=RegistrarListaSt(<T>Lista<T>, <T>VisorWebConfigD.RID<T>)<BR>EjecutarSQL(<T>EXEC spOrdenarMaestro :tEstacion, :tTabla, NULL, NULL,  :tDetalle, NULL<T>, EstacionTrabajo, <T>VisorWeb<T>, Info.Categoria)
[Lista.Columnas]
0=44
1=129


















2=135
3=339

4=-2
[Lista.VisorWebConfigD.TabTitulo]
Carpeta=Lista
Clave=VisorWebConfigD.TabTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.VisorWebConfigD.ZonaTitulo]
Carpeta=Lista
Clave=VisorWebConfigD.ZonaTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.VisorWebConfigD.URL]
Carpeta=Lista
Clave=VisorWebConfigD.URL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco



















[Lista.ListaEnCaptura]
(Inicio)=VisorWebConfigD.TabTitulo
VisorWebConfigD.TabTitulo=VisorWebConfigD.ZonaTitulo
VisorWebConfigD.ZonaTitulo=VisorWebConfigD.URL
VisorWebConfigD.URL=(Fin)















[Forma.ListaAcciones]
(Inicio)=Ordenar
Ordenar=Campos
Campos=(Fin)
