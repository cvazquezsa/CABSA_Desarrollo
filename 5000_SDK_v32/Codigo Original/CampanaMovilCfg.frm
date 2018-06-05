

[Forma]
Clave=CampanaMovilCfg
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Configurar Horarios y Correo

ListaCarpetas=Lista
PosicionInicialIzquierda=508
PosicionInicialArriba=293
PosicionInicialAlturaCliente=200
PosicionInicialAncho=628
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Lista]
Estilo=Ficha
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaMovilCfg
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
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

FiltroGeneral=Empresa = {Comillas(Empresa)}
[Lista.CampanaMovilCfg.HorarioD]
Carpeta=Lista
Clave=CampanaMovilCfg.HorarioD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[Lista.CampanaMovilCfg.HorarioA]
Carpeta=Lista
Clave=CampanaMovilCfg.HorarioA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
Pegado=N
[Lista.CampanaMovilCfg.Duracion]
Carpeta=Lista
Clave=CampanaMovilCfg.Duracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


Tamano=15
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S


























[Lista.CampanaMovilCfg.ServidorSMTP]
Carpeta=Lista
Clave=CampanaMovilCfg.ServidorSMTP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Lista.CampanaMovilCfg.iCalsPath]
Carpeta=Lista
Clave=CampanaMovilCfg.iCalsPath
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco








[Lista.ListaEnCaptura]
(Inicio)=CampanaMovilCfg.HorarioD
CampanaMovilCfg.HorarioD=CampanaMovilCfg.HorarioA
CampanaMovilCfg.HorarioA=CampanaMovilCfg.Duracion
CampanaMovilCfg.Duracion=CampanaMovilCfg.ServidorSMTP
CampanaMovilCfg.ServidorSMTP=CampanaMovilCfg.iCalsPath
CampanaMovilCfg.iCalsPath=(Fin)



[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cancelar
Cancelar=(Fin)
