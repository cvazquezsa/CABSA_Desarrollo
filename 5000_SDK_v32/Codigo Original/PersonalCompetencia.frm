
[Forma]
Clave=PersonalCompetencia
Icono=4
Modulos=(Todos)
Nombre=Competencias del Personal

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=277
PosicionInicialArriba=150
PosicionInicialAlturaCliente=431
PosicionInicialAncho=811
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Personal, Info.Nombre)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Totalizadores=S
PosicionSec1=368
PosicionSec2=183
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalCompetencia
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroAplicaEn=Competencia.Tipo
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=CompetenciaTipo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroEstilo=Directorio
FiltroRespetar=S
FiltroTipo=Automático
CarpetaVisible=S

IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Competencia<T>
ElementosPorPagina=200

PestanaOtroNombre=S
PestanaNombre=Competencias
IconosNombre=PersonalCompetencia:PersonalCompetencia.Competencia
FiltroGeneral=PersonalCompetencia.Personal=<T>{Info.Personal}<T>
[Lista.Competencia.Nombre]
Carpeta=Lista
Clave=Competencia.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.PersonalCompetencia.Peso]
Carpeta=Lista
Clave=PersonalCompetencia.Peso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.PersonalCompetencia.Valor]
Carpeta=Lista
Clave=PersonalCompetencia.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
Competencia=124
Nombre=304
Peso=62
Opcion=261
Valor=64


0=98
1=230
2=129
3=57
4=66
5=-2
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=<T>&Cerrar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S




[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S








[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Calificación<BR>Peso
Totalizadores2=Suma(PersonalCompetencia:ValorPeso)<BR>Suma(PersonalCompetencia:PersonalCompetencia.Peso)
Totalizadores3=#.##<BR>0.00%
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CarpetaVisible=S


[(Carpeta Totalizadores).Peso]
Carpeta=(Carpeta Totalizadores)
Clave=Peso
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]








[Lista.PersonalCompetencia.Observaciones]
Carpeta=Lista
Clave=PersonalCompetencia.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco










[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Calificación
Calificación=Peso
Peso=(Fin)

[(Carpeta Totalizadores).Calificación]
Carpeta=(Carpeta Totalizadores)
Clave=Calificación
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Plata
Efectos=[Negritas]




[Lista.ListaEnCaptura]
(Inicio)=Competencia.Nombre
Competencia.Nombre=PersonalCompetencia.Resultado
PersonalCompetencia.Resultado=PersonalCompetencia.Valor
PersonalCompetencia.Valor=PersonalCompetencia.Peso
PersonalCompetencia.Peso=PersonalCompetencia.Observaciones
PersonalCompetencia.Observaciones=(Fin)

[Lista.PersonalCompetencia.Resultado]
Carpeta=Lista
Clave=PersonalCompetencia.Resultado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco













[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Personalizar
Personalizar=(Fin)
